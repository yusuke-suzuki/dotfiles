module.exports = (context) => {
  const { Syntax, RuleError, report, getSource, locator } = context;
  return {
    [Syntax.Str](node) {
      for (const match of getSource(node).matchAll(/側/g)) {
        report(
          node,
          new RuleError("「側」を使わず、主体や位置を具体的に書いてください。", {
            padding: locator.range([match.index, match.index + match[0].length]),
          }),
        );
      }
    },
  };
};
