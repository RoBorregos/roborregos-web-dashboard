module ReservationsHelper
  def status_reservation(status)
    case status
    when 1
      fa_icon 'circle', title: 'Open', class: 'text-info mr-2', style: 'font-size: 0.6rem; vertical-align: middle;'
    when 2
      fa_icon 'circle', title: 'Open', class: 'text-info mr-2', style: 'font-size: 0.6rem; vertical-align: middle;'
    when 3
      fa_icon 'circle', title: 'Open', class: 'text-info mr-2', style: 'font-size: 0.6rem; vertical-align: middle;'
    when 4
      fa_icon 'circle', title: 'Closed', class: 'text-success mr-2', style: 'font-size: 0.6rem; vertical-align: middle;'
    when 5
      fa_icon 'circle', title: 'Cancelled', class: 'text-danger mr-2', style: 'font-size: 0.6rem; vertical-align: middle;'
    end
  end
end
