package code.model

import net.liftweb.mapper._

object RetroReflection extends RetroReflection with LongKeyedMetaMapper[RetroReflection] {

  override def dbTableName = "retro_reflection"

}

class RetroReflection extends LongKeyedMapper[RetroReflection] with IdPK with OneToMany[Long, RetroReflection] {

  def getSingleton = RetroReflection

  object retro extends MappedLongForeignKey(this, Retro)

  object title extends MappedString(this, 256)

  object retroResponses extends MappedOneToMany(RetroResponse, RetroResponse.retroReflection, OrderBy(RetroResponse.id, Ascending))

  def toReflectionType = ReflectionType(id.get, title.get)
}

case class ReflectionTitle(title: String)
case class ReflectionType(id: Long, title: String)
case class ReflectionTypeWithResponses(id: Long, title: String, responses: List[ResponseType])
