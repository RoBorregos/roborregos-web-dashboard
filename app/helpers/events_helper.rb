module EventsHelper
  def sponsor_options
    Sponsor.pluck(:name, :id)
  end

  def getDateFormatted(field)
    if !@event.start_date.nil?
      if field.to_s == "start_date"
        return @event.start_date.to_date.strftime('%e %b, %Y')
      end 
      if field.to_s == 'end_date'
        return @event.end_date.to_date.strftime('%e %b, %Y')
      end 
    end
  end

  def datepicker_field(form, field)
    form.text_field(
      field,
      class: 'form-control',
      required: true,
      data: {
        'provide': 'datepicker',
        'date-format': 'd M, yyyy',
        'date-viewMode': 'years',
        'date-autoclose': 'true',
        'date-todayBtn': 'linked',
        'date-todayHighlight': 'true',
        'date-orientation': 'bottom left',
      },
      value: getDateFormatted(field)
    ).html_safe
  end
end
