class CampaignDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%Y-%b-%d")
    # h.formatted_date object.created_at
  end

  def goal
    h.number_to_currency object.goal
  end

  def state
    object.aasm_state.capitalize
  end

  def edit_button
    if h.can? :edit, @campaign
      h.link_to "Edit", h.edit_campaign_path(@campaign), class: "btn btn-info"
    end
  end

  def label_class
    {
      "draft" => "label-info",
      "published" => "label-default",
      "cancelled" => "label-danger",
      "funded" => "label-success",
      "unfunded" => "label-danger"
    }.fetch(object.aasm_state, "label-warning")
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
