import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

const resources = {
    en: {
        translation: {
            startQuiz: "Start Test",
            submitAnswer: "Submit Answer",
            finishQuiz: "Finish Test",
            correctAnswers: "Correct Answers",
            incorrectAnswers: "Incorrect Answers",
            restartQuiz: "Restart Test",
        }
    },
    ru: {
        translation: {
            startQuiz: "Начать тестирование",
            submitAnswer: "Отправить ответ",
            finishQuiz: "Завершить тестирование",
            correctAnswers: "Правильно",
            incorrectAnswers: "Неправильно",
            restartQuiz: "Начать заново",
        }
    }
};

i18n
    .use(initReactI18next)
    .init({
        resources,
        lng: "ru",
        interpolation: {
            escapeValue: false
        }
    });

export default i18n;
