class ConstituenciesController < ApplicationController

  def index
    @constituencies = order_list(Constituency.all, :name)

    format({ serialized_data: @constituencies })
  end

  def show
    @constituency = Constituency.find(params[:id]) or not_found
    @members = @constituency.members
    @sittings = order_list_by_through(@members, :sittings, :sittingStartDate)

    format({ serialized_data: { :constituency => @constituency, :members => @members } } )
  end

  def current
    @constituencies = order_list(Constituency.all('current'), :name)

    format({ serialized_data: @constituencies })
  end

  def map
    @constituency = Constituency.find(params[:constituency_id]) or not_found

    format({ serialized_data: @constituency })
  end

  def contact_point
    @constituency = Constituency.find(params[:constituency_id]) or not_found
    @contact_point = @constituency.contact_point

    format({ serialized_data: { :constituency => @constituency, :contact_point => @contact_point } })
  end

  def members
    @constituency = Constituency.find(params[:constituency_id]) or not_found
    @members = @constituency.members
    @sittings = order_list_by_through(@members, :sittings, :sittingStartDate)

    format({ serialized_data: { :constituency => @constituency, :members => @members } })
  end

  def current_members
    @constituency = Constituency.find(params[:constituency_id]) or not_found
    @members = @constituency.members('current')

    format({ serialized_data: { :constituency => @constituency, :members => @members } })
  end

  def letters
    letter = params[:letter]
    @root_path = constituencies_a_z_path
    @constituencies = order_list(Constituency.all(letter), :name)

    format({ serialized_data: @constituencies })
  end

  def current_letters
    letter = params[:letter]
    @root_path = constituencies_current_a_z_path
    @constituencies = order_list(Constituency.all('current', letter), :name)

    format({ serialized_data: @constituencies })
  end

end
