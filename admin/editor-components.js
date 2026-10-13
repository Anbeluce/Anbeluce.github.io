/*
 * Custom "khung ghi chú" / "callout" buttons for the post editor, registered
 * with Decap CMS (https://decapcms.org/docs/custom-widgets/). This is the
 * concrete thing Pages CMS's rich-text field couldn't do: these buttons write
 * Chirpy-theme-specific Kramdown/Liquid syntax — not standard Markdown — so a
 * generic rich-text editor can never offer them out of the box.
 */

// Khung ghi chú (prompt box): > text\n{: .prompt-info }
CMS.registerEditorComponent({
  id: "prompt-box",
  label: "Khung ghi chú (info/tip/warning/danger)",
  fields: [
    {
      name: "type",
      label: "Loại",
      widget: "select",
      default: "info",
      options: [
        { label: "Thông tin (xanh)", value: "info" },
        { label: "Mẹo (xanh lá)", value: "tip" },
        { label: "Cảnh báo (vàng)", value: "warning" },
        { label: "Nguy hiểm (đỏ)", value: "danger" },
      ],
    },
    { name: "body", label: "Nội dung", widget: "text", default: "" },
  ],
  // Matches the two-line block the theme's prompt boxes use. `[\s\S]*?` (not
  // `.*`) so it still matches a body that spans several lines, and `m` so
  // `^`/`$` anchor to each line rather than the whole file.
  pattern: /^> ([\s\S]*?)\n> \{: \.prompt-(info|tip|warning|danger) \}$/m,
  fromBlock: function (match) {
    return { body: match[1], type: match[2] };
  },
  toBlock: function (data) {
    var body = (data.body || "").split("\n").join("\n> ");
    return "> " + body + "\n> {: .prompt-" + (data.type || "info") + " }";
  },
  toPreview: function (data) {
    var colors = {
      info: "#1c7ed6",
      tip: "#2f9e44",
      warning: "#f08c00",
      danger: "#e03131",
    };
    var color = colors[data.type] || colors.info;
    return (
      '<div style="border-left:4px solid ' +
      color +
      ";background:" +
      color +
      '18;padding:0.75em 1em;border-radius:6px;">' +
      (data.body || "") +
      "</div>"
    );
  },
});

// Callout kiểu Notion: <aside>...</aside>
CMS.registerEditorComponent({
  id: "aside-callout",
  label: "Callout kiểu Notion",
  fields: [{ name: "body", label: "Nội dung", widget: "text", default: "" }],
  pattern: /^<aside>\n([\s\S]*?)\n<\/aside>$/m,
  fromBlock: function (match) {
    return { body: match[1] };
  },
  toBlock: function (data) {
    return "<aside>\n" + (data.body || "") + "\n</aside>";
  },
  toPreview: function (data) {
    return (
      '<div style="background:#f2c23018;border-left:4px solid #f2c230;padding:0.75em 1em;border-radius:6px;">' +
      (data.body || "") +
      "</div>"
    );
  },
});
