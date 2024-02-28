import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { initiateQuiz, fetchQuestion, submitAnswer, fetchResults as fetchQuizResults } from '../services/QuizService';
import { Button, Typography, FormControl, FormControlLabel, Checkbox, Box, Container, Grid, Paper } from '@mui/material';


const Quiz = () => {
    const { t, i18n } = useTranslation();
    const [quizStarted, setQuizStarted] = useState(false);
    const [quizUuid, setQuizUuid] = useState('');
    const [currentStep, setCurrentStep] = useState(0);
    const [question, setQuestion] = useState({text: '', options: []});
    const [selectedAnswers, setSelectedAnswers] = useState([]);
    const [results, setResults] = useState(null);


    const changeLanguage = (language) => {
        i18n.changeLanguage(language);
    };

    const startQuiz = async () => {
        const response = await initiateQuiz();
        setCurrentStep(0);
        setResults(null);
        setQuizUuid(response.data.uuid);
        fetchNextQuestion(response.data.uuid, 0);
        setQuizStarted(true);
    };

    const fetchNextQuestion = async (uuid, step) => {
        try {
            const response = await fetchQuestion(uuid, step);
            setQuestion({
                text: response.data.question,
                options: response.data.answers
            });
            setSelectedAnswers([]);
        } catch (error) {
            if (error.response && error.response.status === 404) {
                fetchResults(uuid);
            } else {
                console.error("An error occurred:", error);
            }
        }
    };

    const fetchResults = async (uuid) => {
        try {
            const response = await fetchQuizResults(uuid);
            setResults(response.data);
        } catch (error) {
            console.error("Failed to fetch results:", error);
        }
    };

    const handleAnswerChange = (event) => {
        const value = parseInt(event.target.value, 10);
        setSelectedAnswers(prev => event.target.checked ? [...prev, value] : prev.filter(answer => answer !== value));
    };

    const handleAnswerSubmit = async () => {
        await submitAnswer(quizUuid, currentStep, selectedAnswers);
        const nextStep = currentStep + 1;
        setCurrentStep(nextStep);
        fetchNextQuestion(quizUuid, nextStep);
    };

    return (
        <Container maxWidth="sm">
            <Grid container spacing={2} justifyContent="center">
                <Grid item xs={12}>
                    <Paper elevation={3} style={{ padding: '20px', marginTop: '20px' }}>
                        {!quizStarted ? (
                            <Button variant="contained" color="primary" fullWidth onClick={startQuiz}>{t('startQuiz')}</Button>
                        ) : results ? (
                            <div>
                                <Typography variant="h6">{t('correctAnswers')}</Typography>
                                {results.correct_answers.map((item, index) => (
                                    <Typography key={index}>{item.questionText}</Typography>
                                ))}
                                <Typography variant="h6">{t('incorrectAnswers')}</Typography>
                                {results.incorrect_answers.map((item, index) => (
                                    <Typography key={index}>{item.questionText}</Typography>
                                ))}
                                <Button variant="contained" color="primary" fullWidth onClick={startQuiz}>{t('restartQuiz')}</Button>
                            </div>

                        ) : (
                            <>
                                <Typography variant="h5">{question.text}</Typography>
                                <FormControl component="fieldset" fullWidth>
                                    {question.options.map(option => (
                                        <FormControlLabel
                                            key={option.id}
                                            control={
                                                <Checkbox
                                                    checked={selectedAnswers.includes(option.id)}
                                                    onChange={handleAnswerChange}
                                                    value={option.id}
                                                />
                                            }
                                            label={option.answerText}
                                        />
                                    ))}
                                </FormControl>
                                <Box display="flex" justifyContent="space-between" marginTop="20px">
                                    <Button variant="contained" color="primary" onClick={handleAnswerSubmit}>{t('submitAnswer')}</Button>
                                    <Button variant="contained" color="secondary" onClick={() => fetchResults(quizUuid)}>{t('finishQuiz')}</Button>
                                </Box>
                            </>
                        )}
                    </Paper>
                </Grid>
            </Grid>
            <Button onClick={() => changeLanguage('en')}>EN</Button>
            <Button onClick={() => changeLanguage('ru')}>RU</Button>
        </Container>
    );
};

export default Quiz;
