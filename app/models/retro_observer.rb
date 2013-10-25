class RetroObserver < Mongoid::Observer
  def after_create retro
    retro.retro_reflections << RetroReflection.new(title: 'Went well')
    retro.retro_reflections << RetroReflection.new(title: 'Not so well')
    retro.retro_reflections << RetroReflection.new(title: 'Ideas')
  end
end