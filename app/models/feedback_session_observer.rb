class FeedbackSessionObserver < Mongoid::Observer
  def after_create feedback_session
    feedback_session.retro_reflections << RetroReflection.new(title: 'Went well')
    feedback_session.retro_reflections << RetroReflection.new(title: 'Not so well')
    feedback_session.retro_reflections << RetroReflection.new(title: 'Ideas')
  end
end