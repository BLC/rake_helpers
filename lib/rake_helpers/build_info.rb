class BuildInfo
  def revision
    @revision ||= query_revision('HEAD')
  end

  def date
    Time.now
  end

  def to_action_script
    <<-EOF
public const id:String = "#{revision}"
public const date:Date = new Date(#{js_date_number})
EOF
  end

  private
  # date.to_i is in seconds, javascript dates are constructed from ms (so * 1000)
  def js_date_number
    date.to_i * 1000
  end

  # Stolen mostly from Capistrano::Deploy::SCM::Git
  def query_revision(revision)
    repository = '.'

    raise ArgumentError, "Deploying remote branches is no longer supported.  Specify the remote branch as a local branch for the git repository you're deploying from (ie: '#{revision.gsub('origin/', '')}' rather than '#{revision}')." if revision =~ /^origin\//
    return revision if revision =~ /^[0-9a-f]{40}$/
    # command = scm('ls-remote', repository, revision)
    # result = yield(command)
    result = `git ls-remote #{repository} #{revision}`
    revdata = result.split(/[\t\n]/)
    newrev = nil
    revdata.each_slice(2) do |refs|
      rev, ref = *refs
      if ref.sub(/refs\/.*?\//, '').strip == revision
        newrev = rev
        break
      end
    end
    raise "Unable to resolve revision for '#{revision}' on repository '#{repository}'." unless newrev =~ /^[0-9a-f]{40}$/
    return newrev
  end
end