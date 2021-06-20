const getDay = (dayNumber) => {
    switch (dayNumber) {
        case 0:
            return 'lundi'
        case 1:
            return 'mardi'
        case 2:
            return 'mercredi'
        case 3:
            return 'jeudi'
        case 4:
            return 'vendredi'
        case 5:
            return 'samedi'
        case 6:
            return 'dimanche'
        default:
            return 'lundi';
    }
}

module.exports = getDay;
