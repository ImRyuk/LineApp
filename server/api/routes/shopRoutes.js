module.exports = function(app) {
    const shops = require('../controllers/shopController');

    // shop Routes

    app.route('/shops')
        .get(shops.list_all_shops)
        .post(shops.create_a_shop);

    app.route('/shops/:shopId')
        .get(shops.read_a_shop)
        .put(shops.update_a_shop)
        .delete(shops.delete_a_shop);

    app.route('/search/shops/waitTime/:shopId')
        .get(shops.waitTime);

    app.route('/search/shops/isOpen/:shopId')
        .get(shops.isOpen);

    app.route('/search/shops/:searchString')
        .get(shops.search_shops);
};
