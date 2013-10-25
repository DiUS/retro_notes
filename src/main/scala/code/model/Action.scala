package code.model

import net.liftweb.mapper._

object Action extends Action with LongKeyedMetaMapper[Action] {

  override def dbTableName = "action"

}

class Action extends LongKeyedMapper[Action] with IdPK {

  def getSingleton = Action

  object retro extends MappedLongForeignKey(this, Retro)

  object content extends MappedText(this)

  def toActionType = ActionType(id.get, content.get)

}

case class ActionContent(content: String)
case class ActionType(id: Long, content: String)
