# Redmine List Macros

A small Redmine plugin providing a single wiki macro, `ref_issues`, that renders
an issue table from a saved query — optionally narrowed by an extra exact-match
filter — directly inside a wiki page.

It was written as a lightweight, maintained replacement for the unmaintained
`redmine_wiki_lists` plugin, covering only the features actually in use.

## Requirements

- Redmine 5.0 or higher (tested on 5.0.9; expected to work unchanged on 6.1,
  since the macro registration API is identical across those versions).

## Installation

```bash
cd /path/to/redmine/plugins
git clone https://github.com/ncoders/redmine_list_macros.git
```

Restart your Redmine application server. No database migrations are required.

## Usage

```
{{ref_issues(-i=QUERY_ID, -f:FIELD=VALUE, column1, column2, ...)}}
```

- `-i=QUERY_ID` (required) — the numeric ID of an existing saved query, visible
  to the current user, to use as the base result set.
- `-f:FIELD=VALUE` (optional, repeatable) — adds an exact-match filter on top
  of the saved query, e.g. `-f:fixed_version_id=547`.
- `column1, column2, ...` (optional) — the columns to display, using the same
  names as Redmine's own query column selector (e.g. `tracker`, `status`,
  `cf_11` for custom field 11). If omitted, the saved query's own columns are
  used. The issue `#` column is always included, matching Redmine's own
  behavior for `column_names=`.

### Example

```
{{ref_issues(-i=60, -f:fixed_version_id=547, tracker, status, cf_11)}}
```

Loads saved query #60, adds a `fixed_version_id = 547` filter, and displays
the `tracker`, `status`, and custom field 11 columns. The issue list respects
the saved query's own sort order.

### Errors

Missing or invalid arguments (no `-i=`, an unknown query ID, or an unsupported
option) produce a standard Redmine macro error message in the rendered page
rather than a server error.

## Author

dup2

## License

MIT — see [LICENSE](LICENSE).
