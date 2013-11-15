package code.model

import net.liftweb.mapper._
import code.lib.model.JxMetaMapperHelp

object RetroResponse extends RetroResponse with LongKeyedMetaMapper[RetroResponse] with JxMetaMapperHelp[RetroResponse] {

  override def dbTableName = "retro_response"

}

class RetroResponse extends LongKeyedMapper[RetroResponse] with IdPK {

  def getSingleton = RetroResponse

  object retroReflection extends MappedLongForeignKey(this, RetroReflection)

  object content extends MappedText(this)

}
