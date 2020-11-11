module HasStatus
  extend ActiveSupport::Concern

  included do
    has_paper_trail if: proc { |p| p.saved_change_to_status? }
  end

  class_methods do
    def status(*statuses)
      status_enum = statuses.first.is_a?(Hash) ? statuses.first : statuses
      enum status: status_enum

      status_keys = status_enum.is_a?(Hash) ? status_enum.keys : status_enum

      _define_status_validations(status_keys)
      _define_status_default(status_keys)
      _define_after_status_change_callbacks(status_keys)
    end

    private

    def _define_status_validations(status_keys)
      values = status_keys.map(&:to_s).concat(status_keys.map(&:to_sym))
      validates :status, presence: true, inclusion: { in: values }
    end

    def _define_status_default(status_keys)
      default :status, status_keys.first
    end

    def _define_after_status_change_callbacks(status_keys)
      status_keys.each do |status_key|
        should_call_callback = proc { |record|
          record.status_previously_changed? &&
            record.status_previous_change.last.to_s == status_key.to_s
        }

        after_commit if: should_call_callback do
          callback = self.class.send(:_after_status_change_callback_for, status_key)
          broadcast(callback, self)
        end
      end
    end

    def _after_status_change_callback_for(status_key)
      "after_status_change_to_#{status_key}"
    end
  end
end
