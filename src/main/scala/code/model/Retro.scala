package code.model

import net.liftweb.mapper._

object Retro extends Retro with LongKeyedMetaMapper[Retro] {

  override def dbTableName = "retro"

}

class Retro extends LongKeyedMapper[Retro] with IdPK with OneToMany[Long, Retro] {

  def getSingleton = Retro

  object project extends MappedLongForeignKey(this, Project)

  object title extends MappedString(this, 256)

  object retroReflections extends MappedOneToMany(RetroReflection, RetroReflection.retro, OrderBy(RetroReflection.id, Ascending))
  object actions extends MappedOneToMany(Action, Action.retro, OrderBy(Action.id, Ascending))
}
