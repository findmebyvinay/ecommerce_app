class LocalDatabaseConstants {
  static const String databaseName = 'e_com.db';
}

class LocalDatabaseTable {
  static const String users = 'users';
  static const String products='products';
  // static const String provinces = 'provinces';
  // static const String districts = 'districts';
  // static const String municipality = 'municipality';
  // static const String survey = 'survey';
  // static const String surveyQuestions = 'survey_questions';
  // static const String surveyHeaderQuestions = 'survey_header_questions';
  // static const String notification = 'notification';

  // /// For Response
  // static const String headerResponse = 'header_response';
  // static const String childResponse = 'child_response';
  // static const String headerQuestionResponse = 'header_question_response';
  // static const String childQuestionResponse = 'child_question_response';

  // Add other tables and their fields as needed
}

class CreateTableQueries {
  static const String createUsersTable =
      """
 CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.users} (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT,
    firstname TEXT,
    lastname TEXT,
    gender TEXT,
    image TEXT,
    accessToken TEXT,
    refreshToken TEXT)
 """;


  static const String productsTable=
  """
      CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.products}(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        category TEXT,
        price REAL,
        discountPercentage REAL,
        rating REAL,
        stock INTEGER,
        tags TEXT,
        brand TEXT,
        sku TEXT,
        weight INTEGER,
        dimensions TEXT,
        warrantyInformation TEXT,
        shippingInformation TEXT,
        availabilityStatus TEXT,
        reviews TEXT,
        returnPolicy TEXT,
        minimumOrderQuantity INTEGER,
        meta TEXT,
        images TEXT,
        thumbnail TEXT
      )
  """;
//   static const String createProvincesTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.provinces} (
//   id INTEGER PRIMARY KEY,
//   name TEXT NOT NULL,
//   name_ne TEXT,
//   code TEXT,
//   status INTEGER NOT NULL DEFAULT 1
// )
// """;

//   static const String createDistrictsTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.districts} (
//   ID INTEGER PRIMARY KEY,
//   PROVIENCE_REGION_ID INTEGER NOT NULL,
//   name TEXT NOT NULL,
//   name_ne TEXT,
//   CODE TEXT,
//   STATUS INTEGER NOT NULL DEFAULT 1
// )   """;

//   static const String createMunicipalityTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.municipality} (
//   ID INTEGER PRIMARY KEY,
//   PROVIENCE_REGION_ID INTEGER,
//   DISTRICT_ID INTEGER,
//   name TEXT,
//   name_ne TEXT,
//   lt TEXT,
//   ln TEXT
// )
// """;

//   static const String createSurveyTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.survey} (
//   id INTEGER PRIMARY KEY,
//   title TEXT,
//   order_by INTEGER,
//   description TEXT,
//   user_type TEXT,
//   status INTEGER,
//   category_id INTEGER,
//   created_id INTEGER,
//   updated_id INTEGER,
//   company TEXT, -- store as JSON string or comma-separated list
//   created_at TEXT,
//   updated_at TEXT,
//   hasSection INTEGER,
//   type TEXT,
//   header TEXT, -- store as JSON string
//   title_ne TEXT,
//   description_ne TEXT,
//   reportType TEXT,
//   min_child_limit INTEGER,
//   max_child_limit INTEGER,
//   color TEXT
// )
// """;

//   static const String createSurveyHeaderQuestionsTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.surveyHeaderQuestions} (
//   id INTEGER,
//   question TEXT,
//   qtypeparm INTEGER,
//   question_ne TEXT,
//   dependancy_action TEXT,
//   format TEXT,
//   description TEXT,
//   description_ne TEXT,
//   required INTEGER,
//   is_repeated INTEGER,
//   survey_id INTEGER,
//   qtype INTEGER,
//   is_group INTEGER,
//   age TEXT,
//   order_by INTEGER,
//   vaccine_name TEXT,
//   has_reason TEXT,
//   form_answer TEXT,
//   dependancy_status TEXT,
//   reason TEXT,
//   dependency_questions TEXT, -- Store as JSON string
//   age_range TEXT,            -- Store as JSON string
//   questiontype TEXT,       -- Store JSON string (instead of decomposed fields)
//   questiontypeparam TEXT,
//   answers TEXT,             -- Store as JSON string
//   PRIMARY KEY (id, survey_id)
// )
// """;

//   static const String createSurveyQuestionsTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.surveyQuestions} (
//   id INTEGER,
//   question TEXT,
//   qtypeparm INTEGER,
//   question_ne TEXT,
//   dependancy_action TEXT,
//   format TEXT,
//   description TEXT,
//   description_ne TEXT,
//   required INTEGER,
//   is_repeated INTEGER,
//   survey_id INTEGER,
//   qtype INTEGER,
//   is_group INTEGER,
//   age TEXT,
//   order_by INTEGER,
//   vaccine_name TEXT,
//   has_reason TEXT,
//   form_answer TEXT,
//   dependancy_status TEXT,
//   reason TEXT,
//   dependency_questions TEXT, -- Store as JSON string
//   age_range TEXT,            -- Store as JSON string
//   questiontype TEXT,       -- Store JSON string (instead of decomposed fields)
//   questiontypeparam TEXT,
//   answers TEXT,             -- Store as JSON string
//   PRIMARY KEY (id, survey_id)
// );
// """;

//   static const String createNotificationTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.notification} (
//   id INTEGER PRIMARY KEY,
//   name TEXT,
//   name_ne TEXT,
//   description TEXT,
//   description_ne TEXT,
//   readed INTEGER,
//   created_id INTEGER,
//   updated_id INTEGER,
//   company TEXT,
//   created_at TEXT,
//   updated_at TEXT
// )
// """;

//   /// Tabels for Response
//   static const String createHeaderQuestionResponseTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.headerQuestionResponse} (
//   id INTEGER,
//   question TEXT,
//   qtypeparm INTEGER,
//   question_ne TEXT,
//   dependancy_action TEXT,
//   format TEXT,
//   description TEXT,
//   description_ne TEXT,
//   required INTEGER,
//   is_repeated INTEGER,
//   survey_id INTEGER,
//   qtype INTEGER,
//   is_group INTEGER,
//   age TEXT,
//   order_by INTEGER,
//   vaccine_name TEXT,
//   has_reason TEXT,
//   form_answer TEXT,
//   dependancy_status TEXT,
//   reason TEXT,
//   dependency_questions TEXT, -- Store as JSON string
//   age_range TEXT,            -- Store as JSON string
//   questiontype TEXT,       -- Store JSON string (instead of decomposed fields)
//   questiontypeparam TEXT,
//   answers TEXT,             -- Store as JSON string
//   parent_id TEXT,
//   PRIMARY KEY (id, survey_id, parent_id)
// );
// """;

//   static const String createChildQuestionResponseTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.childQuestionResponse} (
//   id INTEGER,
//   question TEXT,
//   qtypeparm INTEGER,
//   question_ne TEXT,
//   dependancy_action TEXT,
//   format TEXT,
//   description TEXT,
//   description_ne TEXT,
//   required INTEGER,
//   is_repeated INTEGER,
//   survey_id INTEGER,
//   qtype INTEGER,
//   is_group INTEGER,
//   age TEXT,
//   order_by INTEGER,
//   vaccine_name TEXT,
//   has_reason TEXT,
//   form_answer TEXT,
//   dependancy_status TEXT,
//   reason TEXT,
//   dependency_questions TEXT, -- Store as JSON string
//   age_range TEXT,            -- Store as JSON string
//   questiontype TEXT,       -- Store JSON string (instead of decomposed fields)
//   questiontypeparam TEXT,
//   answers TEXT,             -- Store as JSON string
//   image_path TEXT,
//   parent_id TEXT,
//   child_id TEXT,
//   PRIMARY KEY (id, survey_id, parent_id, child_id)
// );
// """;

//   static const String createHeaderResponseTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.headerResponse} (
//   id TEXT PRIMARY KEY,
//   surveyId INTEGER,
//   surveyDate TEXT,
//   province TEXT,
//   district TEXT,
//   municipality TEXT

// );
// """;

//   static const String createChildResponseTable =
//       """
// CREATE TABLE IF NOT EXISTS ${LocalDatabaseTable.childResponse} (
//   id TEXT PRIMARY KEY,
//   parent_id TEXT,
//   survey_id INTEGER

// );
// """;

  // Add other table creation queries as needed
}
