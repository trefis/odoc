Make sure wrapped libraries don't interfere with generating the source code.
Test both canonical paths and hidden units.
It's a simpler case than Dune's wrapping.

  $ odoc compile -c module-main -c srctree-source root.mld

  $ printf "a.ml\nb.ml\nmain.ml\n" > source_tree.map
  $ odoc source-tree -I . --parent page-root -o srctree-source.odoc source_tree.map

  $ ocamlc -c -o main__A.cmo a.ml -bin-annot -I .
  $ ocamlc -c -o main__B.cmo b.ml -bin-annot -I .
  $ ocamlc -c main.ml -bin-annot -I .

  $ odoc compile-src --source-path a.ml --parent srctree-source.odoc -I . main__A.cmt
  $ odoc compile -I . main__A.cmt
  $ odoc compile-src --source-path b.ml --parent srctree-source.odoc -I . main__B.cmt
  $ odoc compile -I . main__B.cmt
  $ odoc compile-src --source-path main.ml --parent srctree-source.odoc -I . main.cmt
  $ odoc compile -I . main.cmt

  $ odoc link -I . src-main__A.odoc
  $ odoc link -I . main__A.odoc
  $ odoc link -I . src-main__B.odoc
  $ odoc link -I . main__B.odoc
  $ odoc link -I . src-main.odoc
  $ odoc link -I . main.odoc

  $ odoc html-generate --source main.ml --indent -o html src-main.odocl
  $ odoc html-generate --indent -o html main.odocl
  $ odoc html-generate --source a.ml --indent -o html src-main__A.odocl
  $ odoc html-generate --hidden --indent -o html main__A.odocl
  $ odoc html-generate --source b.ml --indent -o html src-main__B.odocl
  $ odoc html-generate --hidden --indent -o html main__B.odocl

Look if all the source files are generated:

  $ find html | sort
  html
  html/Main
  html/Main/A
  html/Main/A/index.html
  html/Main/B
  html/Main/B/index.html
  html/Main/index.html
  html/Main__A
  html/Main__A/index.html
  html/Main__B
  html/Main__B/index.html
  html/root
  html/root/source
  html/root/source/a.ml.html
  html/root/source/b.ml.html
  html/root/source/main.ml.html

  $ cat html/Main/A/index.html
  <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml">
   <head><title>A (Main.A)</title><meta charset="utf-8"/>
    <link rel="stylesheet" href="../../odoc.css"/>
    <meta name="generator" content="odoc %%VERSION%%"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <script src="../../highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
   </head>
   <body class="odoc">
    <nav class="odoc-nav"><a href="../index.html">Up</a> – 
     <a href="../index.html">Main</a> &#x00BB; A
    </nav>
    <header class="odoc-preamble">
     <h1>Module <code><span>Main.A</span></code>
      <a href="../../root/source/a.ml.html" class="source_link">Source</a>
     </h1>
    </header>
    <div class="odoc-content">
     <div class="odoc-spec">
      <div class="spec value anchored" id="val-x">
       <a href="#val-x" class="anchor"></a>
       <a href="../../root/source/a.ml.html#val-x" class="source_link">Source
       </a><code><span><span class="keyword">val</span> x : int</span></code>
      </div>
     </div>
    </div>
   </body>
  </html>
