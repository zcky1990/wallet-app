class Entity < ApplicationRecord
    self.inheritance_column = :type # Use 'type' as the STI column
end
