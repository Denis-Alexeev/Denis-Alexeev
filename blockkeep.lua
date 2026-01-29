-- This function handles raw blocks (like comments) in Markdown
function RawBlock(el)
  -- Check if this is a Markdown raw block
  if el.format == "markdown" then
    if el.text:match("<!-- blockkeep%-start -->") then
      -- Insert LaTeX \begin{samepage} at the start marker
      return pandoc.RawBlock("latex", "\\begin{samepage}")
    elseif el.text:match("<!-- blockkeep%-end -->") then
      -- Insert LaTeX \end{samepage} at the end marker
      return pandoc.RawBlock("latex", "\\end{samepage}")
    end
  end
end

-- Additional handler for paragraphs in case Pandoc converts comments to Para
function Para(el)
  if #el.content == 1 and el.content[1].t == "Str" then
    local text = el.content[1].text
    if text:match("<!-- blockkeep%-start -->") then
      -- Start a samepage environment if comment appears as a paragraph
      return pandoc.RawBlock("latex", "\\begin{samepage}")
    elseif text:match("<!-- blockkeep%-end -->") then
      -- End the samepage environment if comment appears as a paragraph
      return pandoc.RawBlock("latex", "\\end{samepage}")
    end
  end
end
