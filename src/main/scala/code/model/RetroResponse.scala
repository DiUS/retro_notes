package code.model

import net.liftweb.mapper._

object RetroResponse extends RetroResponse with LongKeyedMetaMapper[RetroResponse] with JxHelp[RetroResponse] {

  override def dbTableName = "retro_response"

}

class RetroResponse extends LongKeyedMapper[RetroResponse] with IdPK {

  def getSingleton = RetroResponse

  object retroReflection extends MappedLongForeignKey(this, RetroReflection)

  object content extends MappedText(this)

}
