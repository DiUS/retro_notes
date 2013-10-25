package code.model

import net.liftweb.mapper._

object RetroReflection extends RetroReflection with LongKeyedMetaMapper[RetroReflection] {

  override def dbTableName = "retro_reflection"

}

class RetroReflection extends LongKeyedMapper[RetroReflection] with IdPK {

  def getSingleton = RetroReflection

  object retro extends MappedLongForeignKey(this, Retro)

  object title extends MappedString(this, 256)

}
