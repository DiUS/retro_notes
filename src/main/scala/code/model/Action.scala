package code.model

import net.liftweb.mapper._
import code.lib.model.JxMetaMapperHelp

object Action extends Action with LongKeyedMetaMapper[Action] with JxMetaMapperHelp[Action] {

  override def dbTableName = "action"

}

class Action extends LongKeyedMapper[Action] with IdPK {

  def getSingleton = Action

  object retro extends MappedLongForeignKey(this, Retro)

  object content extends MappedText(this)

}
