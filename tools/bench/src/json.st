import json
func jsonParse() {

    jsonObject := "{\"retweet_count\":0,\"in_reply_to_user_id\":null,\"favorited\":false,\"created_at\":\"Tue Dec 06 22:21:24 +0000 2011\",\"in_reply_to_screen_name\":null,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"user\":{\"profile_link_color\":\"ff6eff\",\"protected\":false,\"default_profile_image\":false,\"following\":null,\"created_at\":\"Thu Oct 07 21:16:47 +0000 2010\",\"friends_count\":302,\"name\":\"\\ue12f\\ue12fYC\\ue12f\\ue12f\",\"notifications\":null,\"profile_background_color\":\"000000\",\"is_translator\":false,\"statuses_count\":2990,\"profile_background_tile\":true,\"utc_offset\":-18000,\"description\":\"For Flyers,Cd Covers,Logo\'s,Posters,\& etc. Email me at ryn_richmond@yahoo.com #TeamHIM #TeamSelfMade #TeamPaperChaser\",\"default_profile\":false,\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/367539460\\/TWITTER.jpg\",\"favourites_count\":4,\"profile_sidebar_fill_color\":\"000000\",\"follow_request_sent\":null,\"geo_enabled\":false,\"profile_sidebar_border_color\":\"9e9da3\",\"location\":\"Rhode\\ue12fTo\\ue12fRiches\",\"show_all_inline_media\":false,\"lang\":\"en\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/1677869109\\/image_normal.jpg\",\"screen_name\":\"SELF_MADE_HIM\",\"listed_count\":0,\"verified\":false,\"profile_use_background_image\":true,\"url\":null,\"time_zone\":\"Quito\",\"profile_text_color\":\"a8a3a3\",\"id\":199841786,\"id_str\":\"199841786\",\"contributors_enabled\":false,\"profile_background_image_url\":\"http:\\/\\/a2.twimg.com\\/profile_background_images\\/367539460\\/TWITTER.jpg\",\"followers_count\":320,\"profile_image_url\":\"http:\\/\\/a2.twimg.com\\/profile_images\\/1677869109\\/image_normal.jpg\"},\"retweeted\":false,\"truncated\":false,\"in_reply_to_user_id_str\":null,\"entities\":{\"urls\":[],\"hashtags\":[],\"user_mentions\":[]},\"place\":null,\"geo\":null,\"source\":\"\\u003Ca href=\\\"http:\\/\\/twitter.com\\/#!\\/download\\/iphone\\\" rel=\\\"nofollow\\\"\\u003ETwitter for iPhone\\u003C\\/a\\u003E\",\"contributors\":null,\"coordinates\":null,\"id\":144179660144640000,\"id_str\":\"144179660144640000\",\"text\":\"I tell em fall back cuz if u hate u get put in a box quick\"}"
    jsonArray := "["
    i := 0
    count := 20 // bus error with 20 !
    while (i < count) {
        jsonArray = jsonArray + jsonObject
        i = i +1
        if (i != count) {
            jsonArray = jsonArray + ", "
        }
    }
    jsonArray = jsonArray + "]"

    i = 0
    while (i < 100) {
        json.parse(jsonArray)
        i = i + 1
    }
}