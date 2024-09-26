const String SURVEY_TITLE = 'Contributing Factors to Moral Distress (MoD)';
const String SURVEY_INSTRUCTIONS = 'Please check contributors to your '
    'distress.'
    '\n\n'
    'There are a variety of internal and external constraints that can '
    'contribute to the experience of moral distress. Please put a check next '
    'to any and all indicators that led to your MoD temperature rating. '
    'If other things not included in the list contributed, please select the '
    '"other" option.';
const String SURVEY_EXPAND_TEXT = 'details';
const String SURVEY_COLLAPSE_TEXT = 'less';
const String SURVEY_SUBMIT_BUTTON = 'Submit';
const String SURVEY_TOASTER_MESSAGE = 'Thank You - Your response has been '
    'recorded and will be escalated if aggregate scores are high enough.';
const int SURVEY_TOASTER_DURATION = 3;
const double SURVEY_TOASTER_FONT_SIZE = 15;
const double SURVEY_NO_SELCTIONS_REQUIRED_SCORE = 3;

// TODO: Does this path work?
const String SURVEY_QUESTIONNAIRE_PATH = '../resources/questionnaire.json';
const String SURVEY_BAD_SUBMISSION_TEXT =
    'For scores greater than ${SURVEY_NO_SELCTIONS_REQUIRED_SCORE} please select the contibuting factors';

const String SURVEY_FAILED_SUBMISSION_TITLE = 'Uh-Oh!';
const String SURVEY_FAILED_SUBMISSION_TEXT = 'We are having a hard time submitting your report.';
const String SURVEY_FAILED_SUBMISSION_TEXT_2 = 'Please check your internet connection and try again.';
