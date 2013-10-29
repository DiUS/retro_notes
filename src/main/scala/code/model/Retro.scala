package code.model

import net.liftweb.mapper._
import net.liftweb.json._
import net.liftweb.common.Box
import net.liftweb.util.Helpers

object Retro extends Retro with LongKeyedMetaMapper[Retro] with JxMetaHelp[Retro] {

  override def dbTableName = "retro"


}

class Retro extends LongKeyedMapper[Retro] with IdPK with OneToMany[Long, Retro] with JxHelp[Retro] {

  def getSingleton = Retro

  object project extends MappedLongForeignKey(this, Project)

  object title extends MappedString(this, 256)

  object retroReflections extends MappedOneToMany(RetroReflection, RetroReflection.retro, OrderBy(RetroReflection.id, Ascending))
  object actions extends MappedOneToMany(Action, Action.retro, OrderBy(Action.id, Ascending))

  def createReflection(content: String): Option[RetroReflection] = {
    Option(content) match {
      case None => None
      case Some(c) => Some(RetroReflection.create.content(c))
    }
  }

}

