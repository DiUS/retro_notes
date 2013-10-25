package code.model

import net.liftweb.mapper._

object RetroResponse extends RetroResponse with LongKeyedMetaMapper[RetroResponse] {

  override def dbTableName = "retro_response"

}

class RetroResponse extends LongKeyedMapper[RetroResponse] with IdPK {

  def getSingleton = RetroResponse

  object retroReflection extends MappedLongForeignKey(this, RetroReflection)

  object content extends MappedText(this)

}

case class ResponseContent(content: String)
case class ResponseType(id: Long, content: String)