function RawBlock(el)
  if el.format == "markdown" then
    if el.text:match("<!-- blockkeep%-start -->") then
      return pandoc.RawBlock("latex", "\\begin{samepage}")
    end
    if el.text:match("<!-- blockkeep%-end -->") then
      return pandoc.RawBlock("latex", "\\end{samepage}")
    end
  end
end
