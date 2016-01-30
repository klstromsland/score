json.array!(@scorecards) do |scorecard|
  json.extract! scorecard, :id, :element, :maxpoint, :maxtime, :hides_found, :hides_missed, :finish_call, :false_alert_fringe, :timed_out, :time_elapsed, :eliminated_during_search, :dismissed, :excused, :other_faults_descr, :other_faults_count, :comments, :judge_signature, :pronounced, :total_faults, :total_points
  json.url scorecard_url(scorecard, format: :json)
end
