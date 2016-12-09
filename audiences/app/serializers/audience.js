import ApplicationSerializer from './application';

export default ApplicationSerializer.extend({
    normalizeResponse(store, primaryModelClass, payload) {

        payload.audiences = payload.data;
        delete payload.data;
        
        return this._super(...arguments);
    },
});
