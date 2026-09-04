#!/bin/bash
set -uo pipefail

file="${1:?usage: validate-message.sh <message-file>}"
fail=0
err() { echo "NG: $*"; fail=1; }

subject=$(head -n 1 "$file")
len=$(printf %s "$subject" | wc -m)
[ "$len" -le 50 ] || err "subject is $len chars (max 50 including type and scope)"
case "$subject" in
    *.) err "subject must not end with a period" ;;
esac
printf %s "$subject" | grep -Eq \
    '^(feat|fix|perf|deps|revert|docs|style|chore|refactor|test|build|ci)(\([^)]+\))?!?: .' ||
    err "subject must be '<type>(<scope>)?: <summary>' with a changelog-listed type"

first_word=$(printf %s "$subject" | sed -E 's/^[^:]*: *//' | awk '{print tolower($1)}')
case "$first_word" in
    added|adds|fixed|fixes|updated|updates|removed|removes|changed|changes|\
    improved|improves|refactored|implemented|created|renamed|moved|deleted|\
    corrected|resolved|adjusted|replaced|introduced)
        err "subject verb '$first_word' — use imperative present (add, fix, update, ...)" ;;
esac

[ -z "$(sed -n 2p "$file")" ] ||
    err "line 2 must be blank (subject and body are separated by a blank line)"

lineno=0
while IFS= read -r line || [ -n "$line" ]; do
    lineno=$((lineno + 1))
    [ "$lineno" -le 2 ] && continue
    case "$line" in
        *[[:space:]]*) ;;
        *) continue ;;
    esac
    case "$line" in
        Co-Authored-By:\ *|Signed-off-by:\ *|Claude-Session:\ *|Refs:\ *|\
        BREAKING\ CHANGE:\ *) continue ;;
    esac
    [ "$(printf %s "$line" | wc -m)" -le 72 ] || err "line $lineno exceeds 72 chars"
    printf %s "$line" | grep -Eq '[a-z]{2}[.!?] +[A-Z]' &&
        echo "CHECK line $lineno: possible mid-line sentence break — start each sentence on a new line"
done < "$file"

phrases=$(grep -Eino \
    'this (commit|pr|change)|also fix(es)?|during (the )?review|based on (the |reviewer )?feedback|as requested|per (the )?review' \
    "$file" || true)
if [ -n "$phrases" ]; then
    err "iteration-history phrasing (describe the final diff, not how it evolved):
$phrases"
fi

[ "$fail" -eq 0 ] && echo "OK: message passes mechanical checks"
exit "$fail"
