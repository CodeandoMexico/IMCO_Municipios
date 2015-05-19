module DashboardHelper
  def kpis
    [{
      panel: 'panel-primary',
      awesome_icons_class: 'fa fa-comments fa-5x',
      value: 26,
      message: 'New Comments!',
      path: '#'
    },
    {
      panel: 'panel-green',
      awesome_icons_class: 'fa fa-tasks fa-5x',
      value: 12,
      message: 'New Tasks!',
      path: '#'
    },
    {
      panel: 'panel-yellow',
      awesome_icons_class: 'fa fa-shopping-cart fa-5x',
      value: 124,
      message: 'New Orders!',
      path: '#'
    },
    {
      panel: 'panel-red',
      awesome_icons_class: 'fa fa-support fa-5x',
      value: 13,
      message: 'Support Tickets!',
      path: '#'
    }
  ]
  end
end
