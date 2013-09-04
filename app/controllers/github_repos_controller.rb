class GithubReposController < ApplicationController

  def index
  end

  def commit_activity
    repo = GithubRepo.find(params[:id])
    commit_activity = repo.commit_activity
    categories, series = commit_activity_areachart(commit_activity)
    # result = { categories: categories, series: series }
    area_chart = {
                    chart: {
                        type: 'areaspline'
                    },
                    title: {
                        text: nil
                    },
                    xAxis: {
                        categories: nil,
                        enabled: true
                    },
                    credits: {
                        enabled: false
                    },
                    series: nil
                 }
    area_chart[:xAxis][:categories] = categories
    area_chart[:series] = series
    area_chart[:title][:text] = "Commit Activity"
    render json: area_chart
  end





  def commit_activity_areachart commit_activity
    categories  = commit_activity.map { |commit| commit[:timestamp] }
    adds        = commit_activity.map { |commit| commit[:adds] }
    dels        = commit_activity.map { |commit| -1*commit[:dels] }
    series      = [{ name: "Additions", data: adds }, { name: "Deletions", data: dels }] 
    return categories, series
  end

end



