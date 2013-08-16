module ApplicationHelper

  def validation_error(message)
    if message.class.to_s == "Array"
      message = message.join(",")
    end
    return !message.to_s.blank? ? ("<div class='form_error' style='color: red;'>"+message.to_s+"</div>").html_safe : ""
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def orders_chart_series(orders, start_time)
    if orders.name == 'Order'
      orders_by_day = orders.where(:created_at => start_time.beginning_of_day..Time.zone.now.end_of_day).
        group("date(created_at)").
        select("created_at, sum(net_payment) as net_payment")
      (start_time.to_date..Date.today).map do |date|
        order = orders_by_day.detect { |order| order.created_at.to_date == date }
        order && order.net_payment.to_f || 0
      end.inspect
    else
      orders_by_day = orders.where(:created_at => start_time.beginning_of_day..Time.zone.now.end_of_day).
        group("date(created_at)").
        select("created_at, sum(price) as price")
      (start_time.to_date..Date.today).map do |date|
        order = orders_by_day.detect { |order| order.created_at.to_date == date }
        order && order.price.to_f || 0
      end.inspect
    end
  end
end
