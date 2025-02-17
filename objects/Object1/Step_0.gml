if (keyboard_check_pressed(vk_space))
{
    var g = [
        "TEST",
        "TESTFUCK",
        "STUPID FUCK1NG SH1T",
        "SCUNTHORPE",
        "SCNSUPNC",
        "3hr903fd",
        "@ S S",
        "a S S",
        "WHAT THE HELL IS GOING ON",
        "the grass is green",
        "fuckingocunto ",
        "cunt bassist ass",
        "grasshole @55 455 45535",
        "ahshit shitake mushroom",
        "f#ck",
        "ohmyfuckinggod",
        "SH!T!!!",
        "assassin",                     // Contains "ass" but as part of a larger, acceptable word.
        "classic",                      // "ass" is embedded but should be allowed.
        "massive",                      // Contains "ass" inside; should not be flagged.
        "f u c k",                      // Letters separated by spaces.
        "F.U.C.K",                      // Dotted version.
        "sh1t",                         // Leetspeak version of "shit".
        "s.h.i.t",                      // Dot-separated letters.
        "bullshit",                     // Compound profanity.
        "bitchslap",                    // Compound word; behavior depends on filter logic.
        "nasty ass",                    // Standalone "ass" should be flagged.
        "he is a dumbass",              // Contains "dumbass".
        "whorehouse",                   // Compound word with profanity.
        "f@ck",                        // Variation using symbol @.
        "f u c k i n g",                // Letters spaced out.
        "b1tch",                        // Leetspeak variant of "bitch".
        "sh!t",                         // Variation for "shit".
        "motherfucker",                 // Extreme profanity.
        "fuck off",                     // Two-word phrase.
        "you fucking idiot",            // Contains profanity.
        "shit, damn it",                // Multiple profanities with punctuation.
        "damnation",                    // Compound word; may be flagged depending on rules.,
     "badass",                    // Should ideally censor "ass" only if that’s desired
     "smartass",                  // Tests if “ass” in compound words is flagged or not
     "passion",                   // Should pass (contains "ass" but isn’t profane)
     "embarrassing",              // Contains "ass" – edge-case for word-boundary checks
     "glass",                     // Should pass; “ass” is part of a common word
     "titan",                     // Clean, even though it shares letters with profanity
     "fuckery",                   // Should censor the profane part, if desired
     "F.U.C.K",                   // Dotted letters—should be normalized and censored
     "f u c k",                   // Spaced letters—should be detected if you normalize spaces
     "b1tch",                     // Leetspeak for “bitch”
     "c0cksucker",                // Leetspeak variant of “cocksucker”
     "m0therfucker",              // Leetspeak variant of “motherfucker”
     "fucker",                    // Less extreme form
     "fux0r",                     // Creative leetspeak variant
     "nigg3r",                   // Extreme slur (be careful if you add it)
     "bastard",                   // Should be censored if on your list
     "dickhead",                  // Compound profanity
     "wanker",                    // Included in your list already
     "assassin",                  // Already tested: returns "***assin"
     "classic",                   // Already tested: remains "classic"
     "whorehouse",                // Should censor the "whore" portion (e.g., "*****house")
     "motherfucking",             // Longer compound: should censor the profane part
     "F#CKING",                   // Variation with symbols—requires normalization
     "S.H.I.T!",                  // Dot-separated with punctuation
     "sh!take",                   // Edge-case: intended word vs. profane substring?
     "ass hat",                   // Space-separated profane phrase
     "cuntastic",                 // Compound word containing profanity
     "fuck-off",                  // Hyphenated phrase
     "holy fuck!",                // Common exclamation
     "damnation",                 // Already tested: becomes "****ation"
     "oh my fucking god",         // Should censor the profane word
     "fuck",                      // Basic
     "fucking",                   // Basic
     "cunt",                      // Basic
     "shit",                      // Basic
     "bitch",                     // Basic
     "ass",                       // Basic (should be censored only when it’s a standalone word in normal mode)
     "asses"                      // Plural of “ass”
    ]
    
    array_foreach(g, function(_value)
    {
        var t = current_time;
        
        var h = profanity_filter(_value)
        show_debug_message(_value)
        show_debug_message(h)
        show_debug_message("\n")
        // show_debug_message($"{current_time - t} // {_value}: {h}")
    })
}