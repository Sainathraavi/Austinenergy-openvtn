class VenHealth
  attr_reader :status, :summary, :health, :name, :one_min_avg, :five_min_avg, :hour_avg, :day_avg

  def initialize(ven)
    init(ven)
  end
  def health_status
    health_hash = {good: 0, ok: 1, bad: 2}
    health_hash[@health]
  end
private


  def init (ven)


  	@one_min_avg = ven.ven_polls.where('created_at >= ?', 1.minute.ago).count() / 6.0
  	@five_min_avg = ven.ven_polls.where('created_at >= ?', 5.minute.ago).count() / 30.0
  	@hour_avg = ven.ven_polls.where('created_at >= ?', 60.minute.ago).count() / 360.0
  	@day_avg = ven.ven_polls.where('created_at >= ?', 1.day.ago).count() / 8640.0

  	if @one_min_avg >= 0.8 then
  		@health = :good
  	elsif @one_min_avg>= 0.65 then
  		@health = :ok
  	else
  		@health = :bad
  	end


    @name=ven.name
  	@status={:health => health,
      :one_min => @one_min_avg,
      :five_min => @five_min_avg,
  		:one_hour => @hour_avg,
      :one_day => @day_avg}
    @summary="#{ven.name} health is #{@health}"

  end

end
