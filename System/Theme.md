# System:Theme

# Goad theme for SilverBullet

Adaptive light/dark theme (follows SilverBullet's own toggle) + styled
admonitions, screenshots and code blocks. Applies space-wide. After editing,
run `Ctrl-Alt-r` (System: Reload).

```space-style
/* priority: 5 */

/* ============ Palettes ============ */
html {
  /* --- light: warm "lab paper" --- */
  --c-root:   #f8f8fa;
  --c-panel:  #ffffff;
  --c-panel2: #eef0f6;
  --c-text:   #23262e;
  --c-subtle: #6a7080;
  --c-accent: #5757c8;
  --c-link:   #4747bd;
  --c-code:   #ecebf2;
  --c-border: #e3e4ec;

  --note-col:    #2563eb;
  --warning-col: #d97706;
  --danger-col:  #dc2626;
  --success-col: #16a34a;
}

html[data-theme="dark"] {
  /* --- dark: cool slate --- */
  --c-root:   #13131a;
  --c-panel:  #191922;
  --c-panel2: #21212c;
  --c-text:   #dcdde4;
  --c-subtle: #8d93a4;
  --c-accent: #8d8df7;
  --c-link:   #9898f0;
  --c-code:   #20202b;
  --c-border: #2b2b38;

  --note-col:    #60a5fa;
  --warning-col: #fbbf24;
  --danger-col:  #f87171;
  --success-col: #4ade80;
}

/* ============ Core look ============ */
html {
  --root-background-color: var(--c-root);
  --root-color: var(--c-text);

  --ui-accent-color: var(--c-accent);
  --link-color: var(--c-link);
  --link-missing-color: var(--c-danger-col);
  --subtle-color: var(--c-subtle);
  --subtle-background-color: var(--c-panel2);

  --top-color: var(--c-text);
  --top-background-color: var(--c-panel);
  --top-border-color: var(--c-border);

  --panel-background-color: var(--c-panel);
  --panel-border-color: var(--c-border);

  --bhs-background-color: var(--c-panel);
  --bhs-border-color: var(--c-border);

  --modal-background-color: var(--c-panel);
  --modal-border-color: var(--c-border);
  --modal-header-label-color: var(--c-accent);

  --action-button-color: var(--c-subtle);
  --action-button-hover-color: var(--c-accent);
  --action-button-active-color: var(--c-accent);

  --editor-caret-color: var(--c-accent);
  --editor-selection-background-color: color-mix(in srgb, var(--c-accent), transparent 82%);
  --editor-panels-bottom-background-color: var(--c-panel2);
  --editor-panels-bottom-border-color: var(--c-border);
  --editor-panels-bottom-color: var(--c-subtle);

  --editor-heading-color: var(--c-text);
  --editor-heading-meta-color: var(--c-subtle);
  --editor-link-color: var(--c-link);
  --editor-link-url-color: var(--c-link);
  --editor-wiki-link-page-color: var(--c-link);
  --editor-wiki-link-page-missing-color: var(--c-link-missing-color);
  --editor-ruler-color: var(--c-border);
  --editor-line-meta-color: var(--c-subtle);
  --editor-meta-color: var(--c-subtle);
  --editor-frontmatter-background-color: var(--c-panel2);
  --editor-frontmatter-color: var(--c-subtle);
  --editor-frontmatter-marker-color: var(--c-subtle);
  --editor-widget-background-color: var(--c-panel2);
  --editor-list-bullet-color: var(--c-accent);
  --editor-struct-color: var(--c-warning-col);
  --editor-highlight-background-color: color-mix(in srgb, var(--c-warning-col), transparent 78%);

  /* inline code + fenced code */
  --editor-code-background-color: var(--c-code);
  --editor-code-color: var(--c-text);
  --editor-code-comment-color: color-mix(in srgb, var(--c-subtle), transparent 40%);
  --editor-code-variable-color: var(--c-accent);
  --editor-code-typename-color: color-mix(in srgb, var(--c-note-col), var(--c-accent) 30%);
  --editor-code-string-color: var(--c-success-col);
  --editor-code-number-color: color-mix(in srgb, var(--c-warning-col), var(--c-text) 20%);
  --editor-code-operator-color: var(--c-subtle);
  --editor-code-atom-color: var(--c-note-col);
  --editor-code-info-color: var(--c-subtle);

  /* tables */
  --editor-table-head-background-color: var(--c-panel2);
  --editor-table-head-color: var(--c-text);
  --editor-table-even-background-color: color-mix(in srgb, var(--c-code), transparent 50%);

  /* blockquotes */
  --editor-blockquote-background-color: var(--c-panel2);
  --editor-blockquote-color: var(--c-text);
  --editor-blockquote-border-color: var(--c-accent);

  /* ============ Admonitions (editor + live preview) ============ */
  --editor-admonition-note-border-color: var(--note-col);
  --editor-admonition-note-background-color: color-mix(in srgb, var(--note-col), transparent 92%);
  --editor-admonition-warning-border-color: var(--warning-col);
  --editor-admonition-warning-background-color: color-mix(in srgb, var(--warning-col), transparent 92%);
  --editor-admonition-danger-border-color: var(--danger-col);
  --editor-admonition-danger-background-color: color-mix(in srgb, var(--danger-col), transparent 92%);
  --editor-admonition-success-border-color: var(--success-col);
  --editor-admonition-success-background-color: color-mix(in srgb, var(--success-col), transparent 92%);
  --editor-admonition-info-border-color: var(--note-col);
  --editor-admonition-info-background-color: color-mix(in srgb, var(--note-col), transparent 92%);

  /* ============ Layout & type ============ */
  --editor-width: 64em;
  --editor-font: ui-monospace, "Cascadia Mono", "JetBrains Mono", Menlo,
    Consolas, monospace;
  --ui-font: system-ui, -apple-system, "Segoe UI", Roboto, "Noto Sans",
    sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
}

/* ============ Rendered / preview-side polish ============ */

/* Admonitions: soft card look, both themes */
#sb-root .sb-admonition {
  border-radius: 8px;
  border-left-width: 3px;
  padding: 0.4rem 0.8rem;
}
#sb-root .sb-admonition { border-radius: 8px; }
#sb-root .sb-admonition[admonition="note" i]   { --admonition-color: var(--note-col);    background: color-mix(in srgb, var(--note-col), transparent 93%);    border: 1px solid color-mix(in srgb, var(--note-col), transparent 80%);    border-left: 3px solid var(--note-col); }
#sb-root .sb-admonition[admonition="warning" i]{ --admonition-color: var(--warning-col); background: color-mix(in srgb, var(--warning-col), transparent 93%); border: 1px solid color-mix(in srgb, var(--warning-col), transparent 80%); border-left: 3px solid var(--warning-col); }
#sb-root .sb-admonition[admonition="danger" i] { --admonition-color: var(--danger-col); background: color-mix(in srgb, var(--danger-col), transparent 93%); border: 1px solid color-mix(in srgb, var(--danger-col), transparent 80%); border-left: 3px solid var(--danger-col); }
#sb-root .sb-admonition[admonition="success" i]{ --admonition-color: var(--success-col); background: color-mix(in srgb, var(--success-col), transparent 93%); border: 1px solid color-mix(in srgb, var(--success-col), transparent 80%); border-left: 3px solid var(--success-col); }

/* Embedded screenshots: rounded, framed, never overflow */
#sb-editor .cm-content img,
#sb-root .sb-admonition img {
  border-radius: 10px;
  border: 1px solid var(--c-border);
  max-width: 100%;
  height: auto;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
}

/* Headings get a touch of hierarchy */
.cm-content .cm-header-1 { font-weight: 800; letter-spacing: 0.01em; }
.cm-content .cm-header-2 { font-weight: 700; color: var(--c-accent); }
.cm-content .cm-header-3 { font-weight: 600; }

/* Thinner, calmer scrollbars */
#sb-main ::-webkit-scrollbar { width: 10px; height: 10px; }
#sb-main ::-webkit-scrollbar-thumb {
  background: color-mix(in srgb, var(--c-subtle), transparent 55%);
  border-radius: 8px;
  border-clip: padding-box;
}
#sb-main ::-webkit-scrollbar-track { background: transparent; }
```