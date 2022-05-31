require_relative "room"

require "byebug"

class Hotel
  def initialize(name, hash)
    @name = name
    @rooms = {}
    hash.each { |k, v| @rooms[k] = Room.new(v)}
  end

  def name
    parts = @name.split
    new_parts = parts.map { |part| part.capitalize }
    new_parts.join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    @rooms.has_key?(room_name)
  end

  def check_in(person, room_name)
    if !self.room_exists?(room_name)
        p "sorry, room does not exist"
    else
        if @rooms[room_name].add_occupant(person)
            p "check in successful"
        else
            p "sorry, room is full"
        end
    end
  end

  def has_vacancy?
    @rooms.values.any? { |room| !room.full? }
  end

  def list_rooms
    @rooms.each do |room_name, room|
        puts "#{room_name} : #{room.available_space}"
    end
  end
end