package neuralnews.util;

import neuralnews.dao.UserDAO;
import neuralnews.model.User;
import java.util.List;

public class DBCheck {
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        List<User> users = dao.getAllUsersFiltered(null, null, null, 100, 0);
        System.out.println("Total users found in DB path: " + users.size());
        for (User u : users) {
            System.out.println("User: " + u.getFullName() + " | Email: " + u.getEmail() + " | Role: " + (u.getRole() != null ? u.getRole().getName() : "NULL") + " | Status: " + u.getStatus());
        }
    }
}
