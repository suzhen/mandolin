class ContractAssignment < ApplicationRecord
    belongs_to :contractable, :polymorphic=>true
    belongs_to :contract
end
