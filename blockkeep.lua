-- Lua filter for Pandoc to prevent page breaks in certain blocks
-- Uses the "needspace" LaTeX package

function RawBlock(el)
  if el.format == "markdown" then
    -- Start of block to keep together
    if el.text:match("<!-- blockkeep%-start -->") then
      -- Ensure at least 5 lines of space are available on the current page
      return pandoc.RawBlock("latex", "\\Needspace{5\\baselineskip}")
    end
    -- End of block (nothing needed, Needspace already handles it)
    if el.text:match("<!-- blockkeep%-end -->") then
      return {}
    end
  end
end

