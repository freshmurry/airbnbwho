ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Rooms" do
          ul do
            Room.order(created_at: :desc).limit(5).map do |room|
              li link_to(room.listing_name, edit_admin_room_path(room))
            end
          end
        end
      end

      column do
        panel "Statistics" do
          para "Total Rooms: #{Room.count}"
          para "Total Users: #{User.count}"
          para "Total Reservations: #{Reservation.count}"
        end
      end
    end

    columns do
      column do
        panel "Recent Reviews" do
          ul do
            Review.order(created_at: :desc).limit(5).map do |review|
              li link_to("Review ##{review.id}", Rails.application.routes.url_helpers.admin_comment_path(review))
            end
          end
        end
      end

      column do
        panel "Recent Reservations" do
          ul do
            Reservation.order(created_at: :desc).limit(5).map do |reservation|
              li link_to("Reservation ##{reservation.id}", Rails.application.routes.url_helpers.room_reservation_path(reservation.room_id, reservation))
            end
          end
        end
      end
    end
  end
end