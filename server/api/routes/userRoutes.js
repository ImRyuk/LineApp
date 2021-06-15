module.exports = function(app) {
    const users = require('../controllers/userController');

    // user Routes

    app.route('/users')
        .get(users.list_all_users)
        .post(users.create_a_user);

    app.route('/login')
        .get(users.login_a_user);

    app.route('/users/:userId')
        .get(users.read_a_user)
        .put(users.update_a_user)
        .delete(users.delete_a_user);
};
