;;; esqlite-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (esqlite-read-table-schema esqlite-read-table-columns
;;;;;;  esqlite-read-triggers esqlite-read-indexes esqlite-read-tables
;;;;;;  esqlite-read-views esqlite-read-all-objects esqlite-execute
;;;;;;  esqlite-read-list esqlite-read-atom esqlite-read-top esqlite-read
;;;;;;  esqlite-call/transaction esqlite-call/stream esqlite-async-execute
;;;;;;  esqlite-async-read esqlite-stream-memory esqlite-stream-open
;;;;;;  esqlite-format esqlite-prepare esqlite-format-text esqlite-escape-like
;;;;;;  esqlite-escape-string esqlite-sqlite-installed-p esqlite-file-guessed-database-p
;;;;;;  esqlite-filename-to-uri) "esqlite" "esqlite.el" (21421 4068
;;;;;;  318834 793000))
;;; Generated autoloads from esqlite.el

(autoload 'esqlite-filename-to-uri "esqlite" "\
Construct URI filenames from FILE.

\(esqlite-filename-to-uri \"/path/to/sqlite.db\" '((\"mode\" \"ro\") (\"cache\" \"shared\")))

http://www.sqlite.org/uri.html

\(fn FILE &optional QUERIES)" nil nil)

(defconst esqlite-file-header-regexp "\\`SQLite format 3 " "\
Now support only Sqlite3.")

(autoload 'esqlite-file-guessed-database-p "esqlite" "\
Guess the FILE is a Sqlite database or not.

\(fn FILE)" nil nil)

(autoload 'esqlite-sqlite-installed-p "esqlite" "\
Return non-nil if `esqlite-sqlite-program' is installed.

\(fn)" nil nil)

(autoload 'esqlite-escape-string "esqlite" "\
Escape STRING as a sqlite string object context.
Optional QUOTE-CHAR arg indicate quote-char

e.g.
\(let ((user-input \"a\\\"'b\"))
  (format \"SELECT * FROM T WHERE a = '%s'\" (esqlite-escape-string user-input ?\\')))
  => \"SELECT * FROM T WHERE a = 'a\\\"''b'\"

\(let ((user-input \"a\\\"'b\"))
  (format \"SELECT * FROM T WHERE a = \\\"%s\\\"\" (esqlite-escape-string user-input ?\\\")))
  => \"SELECT * FROM T WHERE a = \\\"a\\\"\\\"'b\\\"\"

\(fn STRING &optional QUOTE-CHAR)" nil nil)

(autoload 'esqlite-escape-like "esqlite" "\
Escape QUERY as a sql LIKE context.
This function is not quote single-quote (') you should use with
`esqlite-escape-string' or `esqlite-format-text'.

ESCAPE-CHAR is optional char (default '\\') for escape sequence expressed
following esqlite syntax.

e.g. fuzzy search of \"100%\" text in `value' column in `hoge' table.
   SELECT * FROM hoge WHERE value LIKE '%100\\%%' ESCAPE '\\'

To create the like pattern:
   => (concat \"%\" (esqlite-escape-like \"100%\" ?\\\\) \"%\")
   => \"%100\\%%\"

\(fn QUERY &optional ESCAPE-CHAR)" nil nil)

(autoload 'esqlite-format-text "esqlite" "\
Convenience function to provide make quoted STRING in sql.

\(fn STRING &optional QUOTE-CHAR)" nil nil)

(autoload 'esqlite-prepare "esqlite" "\
Prepare sql with FMT like `format'.

FMT is a string or list of string.
 each list item join with newline.

Each directive accept arg which contains keyword name.
  Undefined keyword is simply ignored.
e.g.
\(esqlite-prepare \"SELECT * FROM %o{some-table} WHERE id = %s{some-value}\" :some-table \"tbl\")
 => \"SELECT * FROM \"tbl\" WHERE id = %s{some-value}\"

%s: raw text (With no escape)
%t: escape text
%T: same as %t but with quote
%l: escape LIKE pattern escape char is '\\'
%L: similar to %l but with quoting/escaping and ESCAPE statement
%o: escape db object with quote
%O: escape db objects with quote (joined by \", \")
%V: escape sql value(s) with quote if need
  (if list, joined by \", \" without paren)
%X: escape text as hex notation.
    multibyte string is encoded as utf-8 byte array.

\(fn FMT &rest KEYWORDS)" nil nil)

(autoload 'esqlite-format "esqlite" "\
This function is obsoleted should change to `esqlite-prepare'.
This function is not working under `lexical-binding' is t.

Prepare sql with FMT like `format'.

FMT is a string or list of string.
 each list item join with newline.

Each directive accept arg which contains variable name.
  This variable name must not contain `esqlite-' prefix.
e.g.
\(let ((some-var \"FOO\")) (esqlite-format \"%s %s{some-var}\" \"HOGE\"))
 => \"HOGE FOO\"

Format directive is same as `esqlite-prepare'

\(fn fmt &rest objects)" nil nil)

(autoload 'esqlite-stream-open "esqlite" "\
Open FILE stream as sqlite database.
Optional REUSE indicate get having been opened stream.

WARNING: This function return process as `esqlite-stream' object,
 but do not use this as a process object. This object style
 may be changed in future release.

\(fn FILE &optional REUSE)" nil nil)

(autoload 'esqlite-stream-memory "esqlite" "\
Open volatile sqlite database in memory.
KEY should be a non-nil symbol which identify the stream.
If KEY stream has already been opend, that stream is reused.

To save the stream to file, you can use `backup' command.
e.g.
\(esqlite-stream-send-command stream \"backup\" \"filename.sqlite\")

See other information at `esqlite-stream-open'.

\(fn &optional KEY)" nil nil)

(autoload 'esqlite-async-read "esqlite" "\
Execute QUERY in esqlite FILE and immediately exit the esqlite process.
FILTER called with one arg that is parsed csv line or `:EOF'.
  Please use `:EOF' argument finish this async process.
  This FILTER is invoked in process buffer.

If QUERY contains syntax error, raise the error result before return from
this function.
ARGS accept esqlite command arguments. (e.g. -header)

WARNINGS: See `esqlite-hex-to-bytes'.

\(fn FILE QUERY FILTER &rest ARGS)" nil nil)

(autoload 'esqlite-async-execute "esqlite" "\
Utility function to wrap `esqlite-async-read'
This function expect non result set QUERY.
FINALIZE is function which call with no argument.
ARGS are passed to `esqlite-async-read'.

\(fn FILE QUERY &optional FINALIZE &rest ARGS)" nil nil)

(autoload 'esqlite-call/stream "esqlite" "\
Open FILE as esqlite database.
FUNC accept just one arg created stream object from `esqlite-stream-open'.

\(fn FILE FUNC)" nil t)

(put 'esqlite-call/stream 'lisp-indent-function '1)

(autoload 'esqlite-call/transaction "esqlite" "\
Open FILE as esqlite database and begin/commit/rollback transaction.
FUNC accept just one arg created stream object from `esqlite-stream-open'.

\(fn FILE FUNC)" nil t)

(put 'esqlite-call/transaction 'lisp-indent-function '1)

(autoload 'esqlite-read "esqlite" "\
Read QUERY result from sqlite FILE.
This function designed with SELECT QUERY, but works fine another
 sql query (UPDATE/INSERT/DELETE).

ARGS accept some of sqlite command arguments but do not use it
 unless you understand what you are doing.

WARNINGS: See `esqlite-hex-to-bytes'.

\(fn FILE QUERY &rest ARGS)" nil nil)

(autoload 'esqlite-read-top "esqlite" "\
Convenience function with wrapping `esqlite-read' to get a first row
of the results.

No performance advantage. You need to choose LIMIT statement by your own.

\(fn FILE QUERY &rest ARGS)" nil nil)

(autoload 'esqlite-read-atom "esqlite" "\
Convenience function with wrapping `esqlite-read-top' to get a first item
of the results.

\(fn FILE QUERY &rest ARGS)" nil nil)

(autoload 'esqlite-read-list "esqlite" "\
Convenience function with wrapping `esqlite-stream-read'
to get all items as flatten list.

e.g.
SELECT item FROM hoge
 => (\"item1\" \"item2\")

\(fn FILE QUERY &rest ARGS)" nil nil)

(autoload 'esqlite-execute "esqlite" "\
Same as `esqlite-read' but intentional to use non SELECT statement.

\(fn FILE SQL)" nil nil)

(autoload 'esqlite-read-all-objects "esqlite" "\


\(fn STREAM-OR-FILE)" nil nil)

(autoload 'esqlite-read-views "esqlite" "\


\(fn STREAM-OR-FILE)" nil nil)

(autoload 'esqlite-read-tables "esqlite" "\


\(fn STREAM-OR-FILE)" nil nil)

(autoload 'esqlite-read-indexes "esqlite" "\


\(fn STREAM-OR-FILE)" nil nil)

(autoload 'esqlite-read-triggers "esqlite" "\


\(fn STREAM-OR-FILE)" nil nil)

(autoload 'esqlite-read-table-columns "esqlite" "\


\(fn STREAM-OR-FILE TABLE)" nil nil)

(autoload 'esqlite-read-table-schema "esqlite" "\
Get TABLE information in STREAM-OR-FILE.
Elements of the item list are:
0. cid
1. name with lowcase
2. type with UPCASE
3. not null (boolean)
4. default_value
5. primary key (boolean)

\(fn STREAM-OR-FILE TABLE)" nil nil)

;;;***

;;;### (autoloads nil nil ("esqlite-pkg.el") (21421 4068 440464 253000))

;;;***

(provide 'esqlite-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; esqlite-autoloads.el ends here
