module DashboardHelper
  def pretty_kpi_data(kpi_data)
    panels.map do |panel|
      # process the panel
      kpi = kpi_data.shift
      panel[:value] = kpi[:value]
      panel[:message] = kpi[:message]
      # return array element value
      panel
    end
  end

  def panels
    [
      {
        panel: 'panel-primary',
        awesome_icons_class: 'fa fa-comments fa-5x',
        path: '#'
      },
      {
        panel: 'panel-green',
        awesome_icons_class: 'fa fa-area-chart fa-5x',
        path: '#'
      },
      {
        panel: 'panel-red',
        awesome_icons_class: 'fa fa-plus fa-5x',
        path: '#'
      },
      {
        panel: 'panel-purple',
        awesome_icons_class: 'fa fa-clock-o fa-5x',
        path: '#'
      },
      {
        panel: 'panel-yellow',
        awesome_icons_class: 'fa fa-user fa-5x',
        path: '#'
      },
      {
        panel: 'panel-brown',
        awesome_icons_class: 'fa fa-calendar-o fa-5x',
        path: '#'
      }
    ]
  end
end
