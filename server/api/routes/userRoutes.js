module.exports = function(app) {
    const users = require('../controllers/userController');

    // user Routes

    app.route('/users')
        .get(users.list_all_users)

    app.route('/register')
        .post(users.create_a_user);

    app.route('/login')
        .put(users.login_a_user);

    app.route('/users/:userId')
        .get(users.read_a_user)
        .put(users.update_a_user)
        .delete(users.delete_a_user);

    app.route('/users/:userId/shops')
        .get(users.get_all_shops);

    app.route('/admin/shops/unverified')
        .get(users.list_all_unverified);

    app.route('/admin/shops/:shopId/verify')
        .post(users.verify_a_shop);
};
