import axios from 'axios';

const BASE_URL = 'http://quiz.6rv.org/api';

const initiateQuiz = async () => {
    return await axios.post(`${BASE_URL}/start`);
};

const fetchQuestion = async (uuid, step) => {
    return await axios.get(`${BASE_URL}/question/${uuid}/${step}`);
};

const submitAnswer = async (uuid, step, data) => {
    return await axios.post(`${BASE_URL}/submit/${uuid}/${step}`, {answers: data});
};

const fetchResults = async (uuid) => {
    return await axios.get(`${BASE_URL}/results/${uuid}`);
};

export { initiateQuiz, fetchQuestion, submitAnswer, fetchResults };
