#!/usr/bin/env runghc

import Text.Pandoc.JSON

main :: IO ()
main = toJSONFilter addRefEnvItem

addRefEnvItem :: Maybe Format -> Block -> Block
addRefEnvItem (Just (Format "latex"))
  (Div ("refs",["references"],[]) blocks)
    | blocks==[] = Div ("refs",["references"],[]) ([])
    | otherwise = Div ("refs",["references"],[]) ( [latex "\\begin{references}\\sloppy"] ++ concatMap addItem blocks ++ [latex "\\end{references}"] )
  where latex = RawBlock (Format "latex")
addRefEnvItem _ x = x

addItem :: Block -> [Block]
addItem x = [RawBlock (Format "latex") "\\item", x]
