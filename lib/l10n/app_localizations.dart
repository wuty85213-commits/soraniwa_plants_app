import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Farm App'**
  String get title;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @bgm.
  ///
  /// In en, this message translates to:
  /// **'BGM'**
  String get bgm;

  /// No description provided for @se.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get se;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @garden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get garden;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @achievement.
  ///
  /// In en, this message translates to:
  /// **'Achievement'**
  String get achievement;

  /// No description provided for @reward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get reward;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @coinsConsumed.
  ///
  /// In en, this message translates to:
  /// **'Coins Consumed'**
  String get coinsConsumed;

  /// No description provided for @coinsGained.
  ///
  /// In en, this message translates to:
  /// **'Coins Gained'**
  String get coinsGained;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'error'**
  String get error;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'claim'**
  String get claim;

  /// No description provided for @claimed.
  ///
  /// In en, this message translates to:
  /// **'claimed'**
  String get claimed;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get none;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get item;

  /// No description provided for @pot.
  ///
  /// In en, this message translates to:
  /// **'Pot'**
  String get pot;

  /// No description provided for @pots.
  ///
  /// In en, this message translates to:
  /// **'Pots'**
  String get pots;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get credit;

  /// No description provided for @illustration_Credits.
  ///
  /// In en, this message translates to:
  /// **'Illustration Credits'**
  String get illustration_Credits;

  /// No description provided for @bgm_Credits.
  ///
  /// In en, this message translates to:
  /// **'BGM Credits'**
  String get bgm_Credits;

  /// No description provided for @se_Credits.
  ///
  /// In en, this message translates to:
  /// **'SE Credits'**
  String get se_Credits;

  /// No description provided for @illustAC.
  ///
  /// In en, this message translates to:
  /// **'illustAC'**
  String get illustAC;

  /// No description provided for @sound_Effect_Lab.
  ///
  /// In en, this message translates to:
  /// **'Sound Effect Lab'**
  String get sound_Effect_Lab;

  /// No description provided for @text1.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have enough coins to buy it'**
  String get text1;

  /// No description provided for @text2.
  ///
  /// In en, this message translates to:
  /// **'© wuty\nSoraniwa Placollection ～Plant Growing & Collecting Game～'**
  String get text2;

  /// No description provided for @enum_varNOMAL.
  ///
  /// In en, this message translates to:
  /// **'NORMAL'**
  String get enum_varNOMAL;

  /// No description provided for @enum_varGOLD.
  ///
  /// In en, this message translates to:
  /// **'GOLD'**
  String get enum_varGOLD;

  /// No description provided for @enum_varRAINBOW.
  ///
  /// In en, this message translates to:
  /// **'RAINBOW'**
  String get enum_varRAINBOW;

  /// No description provided for @enum_varNone.
  ///
  /// In en, this message translates to:
  /// **'???'**
  String get enum_varNone;

  /// No description provided for @enum_attrLeafy.
  ///
  /// In en, this message translates to:
  /// **'Leafy'**
  String get enum_attrLeafy;

  /// No description provided for @enum_attrBloom.
  ///
  /// In en, this message translates to:
  /// **'Bloom'**
  String get enum_attrBloom;

  /// No description provided for @enum_attrTree.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get enum_attrTree;

  /// No description provided for @enum_attrFun.
  ///
  /// In en, this message translates to:
  /// **'Fun'**
  String get enum_attrFun;

  /// No description provided for @enum_attrOdd.
  ///
  /// In en, this message translates to:
  /// **'Odd'**
  String get enum_attrOdd;

  /// No description provided for @enum_attrNone.
  ///
  /// In en, this message translates to:
  /// **'???'**
  String get enum_attrNone;

  /// No description provided for @enum_ItemTypeSeed.
  ///
  /// In en, this message translates to:
  /// **'seed'**
  String get enum_ItemTypeSeed;

  /// No description provided for @enum_ItemTypeGB.
  ///
  /// In en, this message translates to:
  /// **'Growth Boost Fertilizer'**
  String get enum_ItemTypeGB;

  /// No description provided for @enum_ItemTypeRBRow.
  ///
  /// In en, this message translates to:
  /// **'Basic Fertilizer'**
  String get enum_ItemTypeRBRow;

  /// No description provided for @enum_ItemTypeRBHigh.
  ///
  /// In en, this message translates to:
  /// **'Deluxe Fertilizer'**
  String get enum_ItemTypeRBHigh;

  /// No description provided for @enum_ItemTypeRBSuper.
  ///
  /// In en, this message translates to:
  /// **'Lucky Fertilizer'**
  String get enum_ItemTypeRBSuper;

  /// No description provided for @enum_ItemTypeDeco.
  ///
  /// In en, this message translates to:
  /// **'Decoration'**
  String get enum_ItemTypeDeco;

  /// No description provided for @farm_water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get farm_water;

  /// No description provided for @farm_harvest.
  ///
  /// In en, this message translates to:
  /// **'Harvest'**
  String get farm_harvest;

  /// No description provided for @farm_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get farm_remove;

  /// No description provided for @farm_harvestTitle.
  ///
  /// In en, this message translates to:
  /// **'Harvested!'**
  String get farm_harvestTitle;

  /// No description provided for @farm_harvestReward.
  ///
  /// In en, this message translates to:
  /// **'Harvest Reward'**
  String get farm_harvestReward;

  /// No description provided for @farm_potExpend.
  ///
  /// In en, this message translates to:
  /// **'Add Pot'**
  String get farm_potExpend;

  /// No description provided for @farm_text1.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have enough coins to add a new pot.'**
  String get farm_text1;

  /// No description provided for @farm_text2.
  ///
  /// In en, this message translates to:
  /// **'A new pot has been added'**
  String get farm_text2;

  /// No description provided for @farm_itemlist.
  ///
  /// In en, this message translates to:
  /// **'Item List'**
  String get farm_itemlist;

  /// No description provided for @farm_potlist.
  ///
  /// In en, this message translates to:
  /// **'Pot List'**
  String get farm_potlist;

  /// No description provided for @farm_selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get farm_selected;

  /// No description provided for @farm_text3.
  ///
  /// In en, this message translates to:
  /// **'Please select'**
  String get farm_text3;

  /// No description provided for @farm_plantSeed.
  ///
  /// In en, this message translates to:
  /// **'Seed to Plant'**
  String get farm_plantSeed;

  /// No description provided for @farm_userdItem.
  ///
  /// In en, this message translates to:
  /// **'Item to Use'**
  String get farm_userdItem;

  /// No description provided for @farm_text4.
  ///
  /// In en, this message translates to:
  /// **'There are no seeds to plant'**
  String get farm_text4;

  /// No description provided for @farm_tutorial1.
  ///
  /// In en, this message translates to:
  /// **'1. Plant a seed'**
  String get farm_tutorial1;

  /// No description provided for @farm_tutorial2.
  ///
  /// In en, this message translates to:
  /// **'2. Give it water!'**
  String get farm_tutorial2;

  /// No description provided for @farm_tutorial3.
  ///
  /// In en, this message translates to:
  /// **'3. Harvest it!'**
  String get farm_tutorial3;

  /// No description provided for @farm_tutorialReward.
  ///
  /// In en, this message translates to:
  /// **'Tutorial Reward'**
  String get farm_tutorialReward;

  /// No description provided for @collected_collectedRate.
  ///
  /// In en, this message translates to:
  /// **'Collection Rate'**
  String get collected_collectedRate;

  /// No description provided for @collected_rarity.
  ///
  /// In en, this message translates to:
  /// **'Rarity'**
  String get collected_rarity;

  /// No description provided for @collected_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get collected_type;

  /// No description provided for @collected_harvestCount.
  ///
  /// In en, this message translates to:
  /// **'HarvestCount'**
  String get collected_harvestCount;

  /// No description provided for @ach_unlocked.
  ///
  /// In en, this message translates to:
  /// **'Achieved'**
  String get ach_unlocked;

  /// No description provided for @ach_locked.
  ///
  /// In en, this message translates to:
  /// **'Not Achieved'**
  String get ach_locked;

  /// No description provided for @ach_received.
  ///
  /// In en, this message translates to:
  /// **'claimed'**
  String get ach_received;

  /// No description provided for @ach_achievementReward.
  ///
  /// In en, this message translates to:
  /// **'AchievementReward'**
  String get ach_achievementReward;

  /// No description provided for @store_ad.
  ///
  /// In en, this message translates to:
  /// **'Watch Ad to Get Item'**
  String get store_ad;

  /// No description provided for @store_adReward.
  ///
  /// In en, this message translates to:
  /// **'AdReward'**
  String get store_adReward;

  /// No description provided for @store_owned.
  ///
  /// In en, this message translates to:
  /// **'owned'**
  String get store_owned;

  /// No description provided for @store_text1.
  ///
  /// In en, this message translates to:
  /// **'Please select a quantity'**
  String get store_text1;

  /// No description provided for @store_text2.
  ///
  /// In en, this message translates to:
  /// **'Do you want to proceed with this purchase?'**
  String get store_text2;

  /// No description provided for @store_text3.
  ///
  /// In en, this message translates to:
  /// **'Purchase completed!'**
  String get store_text3;

  /// No description provided for @store_text4.
  ///
  /// In en, this message translates to:
  /// **'Do you want to proceed with this purchase?'**
  String get store_text4;

  /// No description provided for @store_text5.
  ///
  /// In en, this message translates to:
  /// **'Sale completed!'**
  String get store_text5;

  /// No description provided for @store_text6.
  ///
  /// In en, this message translates to:
  /// **'There are no items to sell'**
  String get store_text6;

  /// No description provided for @store_text7.
  ///
  /// In en, this message translates to:
  /// **'You have reached the daily limit of 3 ad views'**
  String get store_text7;

  /// No description provided for @ach_FIRSTBUY_title.
  ///
  /// In en, this message translates to:
  /// **'First Purchase'**
  String get ach_FIRSTBUY_title;

  /// No description provided for @ach_FIRSTBUY_desc.
  ///
  /// In en, this message translates to:
  /// **'Buy an item in the store'**
  String get ach_FIRSTBUY_desc;

  /// No description provided for @ach_FIRSTHARVEST_title.
  ///
  /// In en, this message translates to:
  /// **'First Harvest'**
  String get ach_FIRSTHARVEST_title;

  /// No description provided for @ach_FIRSTHARVEST_desc.
  ///
  /// In en, this message translates to:
  /// **'Harvest a character for the first time'**
  String get ach_FIRSTHARVEST_desc;

  /// No description provided for @ach_Leafy_title.
  ///
  /// In en, this message translates to:
  /// **'Leafy Collection Complete'**
  String get ach_Leafy_title;

  /// No description provided for @ach_Leafy_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete all characters from the Leafy seed type!'**
  String get ach_Leafy_desc;

  /// No description provided for @ach_Bloom_title.
  ///
  /// In en, this message translates to:
  /// **'Bloom Collection Complete'**
  String get ach_Bloom_title;

  /// No description provided for @ach_Bloom_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete all characters from the Bloom seed type!'**
  String get ach_Bloom_desc;

  /// No description provided for @ach_Tree_title.
  ///
  /// In en, this message translates to:
  /// **'Tree Collection Complete'**
  String get ach_Tree_title;

  /// No description provided for @ach_Tree_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete all characters from the Tree seed type!'**
  String get ach_Tree_desc;

  /// No description provided for @ach_Fun_title.
  ///
  /// In en, this message translates to:
  /// **'Fun Collection Complete'**
  String get ach_Fun_title;

  /// No description provided for @ach_Fun_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete all characters from the Fun seed type!'**
  String get ach_Fun_desc;

  /// No description provided for @ach_Odd_title.
  ///
  /// In en, this message translates to:
  /// **'Odd Collection Complete'**
  String get ach_Odd_title;

  /// No description provided for @ach_Odd_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete all characters from the Odd seed type!'**
  String get ach_Odd_desc;

  /// No description provided for @ach_NORMAL1_title.
  ///
  /// In en, this message translates to:
  /// **'Get 1 Normal'**
  String get ach_NORMAL1_title;

  /// No description provided for @ach_NORMAL1_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entry for one Normal character to earn this achievement!'**
  String get ach_NORMAL1_desc;

  /// No description provided for @ach_NORMAL5_title.
  ///
  /// In en, this message translates to:
  /// **'Get 5 Normal'**
  String get ach_NORMAL5_title;

  /// No description provided for @ach_NORMAL5_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for five Normal characters to earn this achievement!'**
  String get ach_NORMAL5_desc;

  /// No description provided for @ach_NORMAL10_title.
  ///
  /// In en, this message translates to:
  /// **'Get 10 Normal'**
  String get ach_NORMAL10_title;

  /// No description provided for @ach_NORMAL10_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for ten Normal characters to earn this achievement!'**
  String get ach_NORMAL10_desc;

  /// No description provided for @ach_NORMAL15_title.
  ///
  /// In en, this message translates to:
  /// **'Get 15 Normal'**
  String get ach_NORMAL15_title;

  /// No description provided for @ach_NORMAL15_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for fifteen Normal characters to earn this achievement!'**
  String get ach_NORMAL15_desc;

  /// No description provided for @ach_NORMAL20_title.
  ///
  /// In en, this message translates to:
  /// **'Get 20 Normal'**
  String get ach_NORMAL20_title;

  /// No description provided for @ach_NORMAL20_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for twenty Normal characters to earn this achievement!'**
  String get ach_NORMAL20_desc;

  /// No description provided for @ach_NORMAL25_title.
  ///
  /// In en, this message translates to:
  /// **'Get 25 Normal'**
  String get ach_NORMAL25_title;

  /// No description provided for @ach_NORMAL25_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for twenty-five Normal characters to earn this achievement!'**
  String get ach_NORMAL25_desc;

  /// No description provided for @ach_NORMAL30_title.
  ///
  /// In en, this message translates to:
  /// **'Get 30 Normal'**
  String get ach_NORMAL30_title;

  /// No description provided for @ach_NORMAL30_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for thirty Normal characters to earn this achievement!'**
  String get ach_NORMAL30_desc;

  /// No description provided for @ach_GOLD1_title.
  ///
  /// In en, this message translates to:
  /// **'Get 1 Gold'**
  String get ach_GOLD1_title;

  /// No description provided for @ach_GOLD1_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entry for one Gold character to earn this achievement!'**
  String get ach_GOLD1_desc;

  /// No description provided for @ach_GOLD5_title.
  ///
  /// In en, this message translates to:
  /// **'Get 5 Gold'**
  String get ach_GOLD5_title;

  /// No description provided for @ach_GOLD5_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for five Gold characters to earn this achievement!'**
  String get ach_GOLD5_desc;

  /// No description provided for @ach_GOLD10_title.
  ///
  /// In en, this message translates to:
  /// **'Get 10 Gold'**
  String get ach_GOLD10_title;

  /// No description provided for @ach_GOLD10_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for ten Gold characters to earn this achievement!'**
  String get ach_GOLD10_desc;

  /// No description provided for @ach_GOLD15_title.
  ///
  /// In en, this message translates to:
  /// **'Get 15 Gold'**
  String get ach_GOLD15_title;

  /// No description provided for @ach_GOLD15_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for fifteen Gold characters to earn this achievement!'**
  String get ach_GOLD15_desc;

  /// No description provided for @ach_GOLD20_title.
  ///
  /// In en, this message translates to:
  /// **'Get 20 Gold'**
  String get ach_GOLD20_title;

  /// No description provided for @ach_GOLD20_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for twenty Gold characters to earn this achievement!'**
  String get ach_GOLD20_desc;

  /// No description provided for @ach_GOLD25_title.
  ///
  /// In en, this message translates to:
  /// **'Get 25 Gold'**
  String get ach_GOLD25_title;

  /// No description provided for @ach_GOLD25_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for twenty-five Gold characters to earn this achievement!'**
  String get ach_GOLD25_desc;

  /// No description provided for @ach_GOLD30_title.
  ///
  /// In en, this message translates to:
  /// **'Get 30 Gold'**
  String get ach_GOLD30_title;

  /// No description provided for @ach_GOLD30_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for thirty Gold characters to earn this achievement!'**
  String get ach_GOLD30_desc;

  /// No description provided for @ach_RAINBOW1_title.
  ///
  /// In en, this message translates to:
  /// **'Get 1 Rainbow'**
  String get ach_RAINBOW1_title;

  /// No description provided for @ach_RAINBOW1_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entry for one Rainbow character to earn this achievement!'**
  String get ach_RAINBOW1_desc;

  /// No description provided for @ach_RAINBOW5_title.
  ///
  /// In en, this message translates to:
  /// **'Get 5 Rainbow'**
  String get ach_RAINBOW5_title;

  /// No description provided for @ach_RAINBOW5_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for five Rainbow characters to earn this achievement!'**
  String get ach_RAINBOW5_desc;

  /// No description provided for @ach_RAINBOW10_title.
  ///
  /// In en, this message translates to:
  /// **'Get 10 Rainbow'**
  String get ach_RAINBOW10_title;

  /// No description provided for @ach_RAINBOW10_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for ten Rainbow characters to earn this achievement!'**
  String get ach_RAINBOW10_desc;

  /// No description provided for @ach_RAINBOW15_title.
  ///
  /// In en, this message translates to:
  /// **'Get 15 Rainbow'**
  String get ach_RAINBOW15_title;

  /// No description provided for @ach_RAINBOW15_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for fifteen Rainbow characters to earn this achievement!'**
  String get ach_RAINBOW15_desc;

  /// No description provided for @ach_RAINBOW20_title.
  ///
  /// In en, this message translates to:
  /// **'Get 20 Rainbow'**
  String get ach_RAINBOW20_title;

  /// No description provided for @ach_RAINBOW20_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for twenty Rainbow characters to earn this achievement!'**
  String get ach_RAINBOW20_desc;

  /// No description provided for @ach_RAINBOW25_title.
  ///
  /// In en, this message translates to:
  /// **'Get 25 Rainbow'**
  String get ach_RAINBOW25_title;

  /// No description provided for @ach_RAINBOW25_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for twenty-five Rainbow characters to earn this achievement!'**
  String get ach_RAINBOW25_desc;

  /// No description provided for @ach_RAINBOW30_title.
  ///
  /// In en, this message translates to:
  /// **'Get 30 Rainbow'**
  String get ach_RAINBOW30_title;

  /// No description provided for @ach_RAINBOW30_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the encyclopedia entries for thirty Rainbow characters to earn this achievement!'**
  String get ach_RAINBOW30_desc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
