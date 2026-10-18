module RedmineListMacros
  module RefIssues
    Redmine::WikiFormatting::Macros.register do
      desc "Displays an issue table from a saved query, with an optional extra filter.\n\n" \
           "{{ref_issues(-i=QUERY_ID, -f:FIELD=VALUE, column1, column2, ...)}}\n\n" \
           "Example: {{ref_issues(-i=60, -f:fixed_version_id=547, tracker, status, cf_11)}}"

      macro :ref_issues do |obj, args|
        query_id = nil
        extra_filters = []
        columns = []

        args.each do |arg|
          case arg
          when /\A-i=(\d+)\z/
            query_id = $1.to_i
          when /\A-f:([^=]+)=(.*)\z/
            extra_filters << [$1, $2]
          when /\A-/
            raise "ref_issues: unsupported option '#{arg}'"
          else
            columns << arg.to_sym
          end
        end

        raise "ref_issues: missing required -i=<query id> argument" unless query_id

        query = IssueQuery.visible.find_by(id: query_id)
        raise "ref_issues: query ##{query_id} not found or not visible to #{User.current}" unless query

        query.user = User.current
        extra_filters.each { |field, value| query.add_filter(field, '=', [value]) }
        query.column_names = columns if columns.any?

        issues = query.issues

        extend QueriesHelper

        content_tag('table', class: 'list issues') do
          thead = content_tag('tr') { safe_join(query.columns.map { |c| content_tag('th', c.caption) }) }
          tbody = safe_join(issues.map { |issue|
            content_tag('tr') {
              safe_join(query.columns.map { |c|
                content_tag('td', column_content(c, issue), style: 'text-align: left')
              })
            }
          })
          content_tag('thead', thead) + content_tag('tbody', tbody)
        end
      end
    end
  end
end
