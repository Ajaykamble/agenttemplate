import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar'), Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Demo app'**
  String get appName;

  /// No description provided for @pageLoginGetStartedWithSynapse.
  ///
  /// In en, this message translates to:
  /// **'Get started with synapse live agent'**
  String get pageLoginGetStartedWithSynapse;

  /// No description provided for @pageLoginUnLimited.
  ///
  /// In en, this message translates to:
  /// **'Ultimate solution for provided excellent customer support'**
  String get pageLoginUnLimited;

  /// No description provided for @pageLoginUserNameOrEmailID.
  ///
  /// In en, this message translates to:
  /// **'User name / Email address'**
  String get pageLoginUserNameOrEmailID;

  /// No description provided for @pageLoginPleaseEnterYourUsername.
  ///
  /// In en, this message translates to:
  /// **'This field is invalid'**
  String get pageLoginPleaseEnterYourUsername;

  /// No description provided for @pageLoginInvalidUsername.
  ///
  /// In en, this message translates to:
  /// **'Invalid username'**
  String get pageLoginInvalidUsername;

  /// No description provided for @pageLoginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get pageLoginPassword;

  /// No description provided for @pageLoginInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get pageLoginInvalidPassword;

  /// No description provided for @pageLoginLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get pageLoginLogin;

  /// No description provided for @pageLoginCustomerSupport.
  ///
  /// In en, this message translates to:
  /// **'customer support'**
  String get pageLoginCustomerSupport;

  /// No description provided for @pageLoginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get pageLoginForgotPassword;

  /// No description provided for @pageProfileMobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile No : '**
  String get pageProfileMobileNo;

  /// No description provided for @pageLoginFooterText.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Vectramind. All rights reserved.'**
  String get pageLoginFooterText;

  /// No description provided for @pageLoginChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get pageLoginChangePassword;

  /// No description provided for @pageProfileProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get pageProfileProfile;

  /// Label for waiting time
  ///
  /// In en, this message translates to:
  /// **'User Wait Time'**
  String get userWaitTime;

  /// No description provided for @pageProfileAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get pageProfileAge;

  /// No description provided for @pageProfileMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile '**
  String get pageProfileMobile;

  /// No description provided for @pageProfileEmailId.
  ///
  /// In en, this message translates to:
  /// **'Email  '**
  String get pageProfileEmailId;

  /// No description provided for @pendingChats.
  ///
  /// In en, this message translates to:
  /// **'Peding Chats'**
  String get pendingChats;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @pageForgotPasswordEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get pageForgotPasswordEnterEmail;

  /// No description provided for @pageProfilePreferredLan.
  ///
  /// In en, this message translates to:
  /// **'Preferred Language'**
  String get pageProfilePreferredLan;

  /// No description provided for @pageLogicLiveAgent.
  ///
  /// In en, this message translates to:
  /// **'live agent'**
  String get pageLogicLiveAgent;

  /// No description provided for @pageAppBarLogOut.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get pageAppBarLogOut;

  /// No description provided for @pageAppBarEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get pageAppBarEnglish;

  /// No description provided for @pageAppBarArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get pageAppBarArabic;

  /// No description provided for @appBarTicket.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get appBarTicket;

  /// No description provided for @pageTicketsManagerBusy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get pageTicketsManagerBusy;

  /// No description provided for @pageTicketsManagerOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get pageTicketsManagerOnline;

  /// No description provided for @pageTicketsManagerOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get pageTicketsManagerOffline;

  /// No description provided for @pageTicketsInfoTicketNo.
  ///
  /// In en, this message translates to:
  /// **'Ticket No : -- '**
  String get pageTicketsInfoTicketNo;

  /// No description provided for @pageTicketsManagerNoTicketsFound.
  ///
  /// In en, this message translates to:
  /// **'No Tickets Found'**
  String get pageTicketsManagerNoTicketsFound;

  /// No description provided for @pageTicketsManagerSearchHintText.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get pageTicketsManagerSearchHintText;

  /// No description provided for @pageStaticsBarChatInQue.
  ///
  /// In en, this message translates to:
  /// **'Chats in\nQue'**
  String get pageStaticsBarChatInQue;

  /// No description provided for @pageTicketsInfoContactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get pageTicketsInfoContactDetails;

  /// No description provided for @pageTicketsInfoPreConversation.
  ///
  /// In en, this message translates to:
  /// **'Pre-Conversations'**
  String get pageTicketsInfoPreConversation;

  /// No description provided for @pageTicketsInfoAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get pageTicketsInfoAccept;

  /// No description provided for @pageTicketsInfoClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get pageTicketsInfoClose;

  /// No description provided for @pageTicketsInfoTransferButton.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get pageTicketsInfoTransferButton;

  /// No description provided for @pageTicketsManagerTicketAcceptedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ticket Accepted SuccessFully'**
  String get pageTicketsManagerTicketAcceptedSuccess;

  /// No description provided for @pageTicketsInfoTransferTicketQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to transfer the Ticket ?'**
  String get pageTicketsInfoTransferTicketQuestion;

  /// No description provided for @pageTicketsInfoAcceptTicketQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to accept the Ticket ?'**
  String get pageTicketsInfoAcceptTicketQuestion;

  /// No description provided for @pageTicketsInfoDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name :'**
  String get pageTicketsInfoDisplayName;

  /// No description provided for @pageSideMenuManagerClosedTickets.
  ///
  /// In en, this message translates to:
  /// **'Closed Tickets'**
  String get pageSideMenuManagerClosedTickets;

  /// No description provided for @pageSideMenuNewTickets.
  ///
  /// In en, this message translates to:
  /// **'New Tickets'**
  String get pageSideMenuNewTickets;

  /// No description provided for @pageSideMenuProcessingTickets.
  ///
  /// In en, this message translates to:
  /// **'Processing Tickets'**
  String get pageSideMenuProcessingTickets;

  /// No description provided for @pageSideMenuTransferTickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets Transfer'**
  String get pageSideMenuTransferTickets;

  /// No description provided for @pageTicketsInfoTicketAcceptedTime.
  ///
  /// In en, this message translates to:
  /// **'Ticket Accepted Time :'**
  String get pageTicketsInfoTicketAcceptedTime;

  /// No description provided for @pageTicketsInfoTransfer.
  ///
  /// In en, this message translates to:
  /// **'Ticket Transfer'**
  String get pageTicketsInfoTransfer;

  /// No description provided for @pageTicketsInfoPleaseAddComment.
  ///
  /// In en, this message translates to:
  /// **'Please enter your comment'**
  String get pageTicketsInfoPleaseAddComment;

  /// No description provided for @pageTicketsInfoAddComment.
  ///
  /// In en, this message translates to:
  /// **'Add Comment'**
  String get pageTicketsInfoAddComment;

  /// No description provided for @pageTicketsInfoComment.
  ///
  /// In en, this message translates to:
  /// **'Comments if any'**
  String get pageTicketsInfoComment;

  /// No description provided for @pageTicketsInfoNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get pageTicketsInfoNo;

  /// No description provided for @pageTicketsInfoYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get pageTicketsInfoYes;

  /// No description provided for @pageChatScreenOfflineMsg.
  ///
  /// In en, this message translates to:
  /// **'Your Offline,so Please change the status as Online to Get access'**
  String get pageChatScreenOfflineMsg;

  /// No description provided for @pageTicketsInfoTransferDialogQuestion.
  ///
  /// In en, this message translates to:
  /// **'Select the agent which you want to transfer the Ticket?'**
  String get pageTicketsInfoTransferDialogQuestion;

  /// No description provided for @pageTicketsInfoTransferValidateString.
  ///
  /// In en, this message translates to:
  /// **'Please Select Agent'**
  String get pageTicketsInfoTransferValidateString;

  /// No description provided for @pageTicketsInfoConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get pageTicketsInfoConfirm;

  /// No description provided for @pageTicketsInfoSelectAgentType.
  ///
  /// In en, this message translates to:
  /// **'Select Type of Agent'**
  String get pageTicketsInfoSelectAgentType;

  /// No description provided for @pageTicketsManagerSelectAgentTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Please select category'**
  String get pageTicketsManagerSelectAgentTypeHint;

  /// No description provided for @pageTicketsInfoSelectAgentSuperVisor.
  ///
  /// In en, this message translates to:
  /// **'Select agent supervisor'**
  String get pageTicketsInfoSelectAgentSuperVisor;

  /// No description provided for @pageTicketsInfoSelectLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Please select language'**
  String get pageTicketsInfoSelectLanguageHint;

  /// No description provided for @pageTicketsInfoNoRolesFound.
  ///
  /// In en, this message translates to:
  /// **'No Roles Found'**
  String get pageTicketsInfoNoRolesFound;

  /// No description provided for @pageTicketsManagerNoAgentFound.
  ///
  /// In en, this message translates to:
  /// **'No Agents Found'**
  String get pageTicketsManagerNoAgentFound;

  /// No description provided for @pageTicketsInfoNoteHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Note'**
  String get pageTicketsInfoNoteHintText;

  /// No description provided for @pageTicketsInfoSelectAnOption.
  ///
  /// In en, this message translates to:
  /// **'End Tag'**
  String get pageTicketsInfoSelectAnOption;

  /// No description provided for @pageTicketInfoSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get pageTicketInfoSelect;

  /// No description provided for @pageTicketsInfoPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get pageTicketsInfoPayment;

  /// No description provided for @pageTicketsInfoAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get pageTicketsInfoAppointment;

  /// No description provided for @pageTicketsInfoReports.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get pageTicketsInfoReports;

  /// No description provided for @pageTicketsInfoOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get pageTicketsInfoOther;

  /// No description provided for @pageTicketsInfoCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get pageTicketsInfoCancel;

  /// No description provided for @pageLogicEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Password'**
  String get pageLogicEnterPassword;

  /// No description provided for @pageChatManagerNoMsgHereYet.
  ///
  /// In en, this message translates to:
  /// **'No Messages here yet '**
  String get pageChatManagerNoMsgHereYet;

  /// No description provided for @pageUserServiceDashBoard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get pageUserServiceDashBoard;

  /// No description provided for @pageUserServiceAgentManagement.
  ///
  /// In en, this message translates to:
  /// **'Agent Manager'**
  String get pageUserServiceAgentManagement;

  /// No description provided for @pageChatManagerPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get pageChatManagerPhoto;

  /// No description provided for @pageCacheErrorDialog.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get pageCacheErrorDialog;

  /// No description provided for @pageChatManagerFile.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get pageChatManagerFile;

  /// No description provided for @pageChatStaticsThree.
  ///
  /// In en, this message translates to:
  /// **'03'**
  String get pageChatStaticsThree;

  /// No description provided for @pageChatStaticOneSeventyEight.
  ///
  /// In en, this message translates to:
  /// **'178'**
  String get pageChatStaticOneSeventyEight;

  /// No description provided for @pageChatStaticsOne.
  ///
  /// In en, this message translates to:
  /// **'01'**
  String get pageChatStaticsOne;

  /// No description provided for @pageTicketCancelText.
  ///
  /// In en, this message translates to:
  /// **'Select Tag'**
  String get pageTicketCancelText;

  /// No description provided for @pageChangePasswordChangePasswordText.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get pageChangePasswordChangePasswordText;

  /// No description provided for @pageChangePasswordHintText.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get pageChangePasswordHintText;

  /// No description provided for @pageChangePasswordOldPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Please enter your old password'**
  String get pageChangePasswordOldPasswordErrorText;

  /// No description provided for @pageChangePasswordNewPasswordText.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get pageChangePasswordNewPasswordText;

  /// No description provided for @pageChangePasswordNewPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get pageChangePasswordNewPasswordErrorText;

  /// No description provided for @pageChangePasswordConfirmPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get pageChangePasswordConfirmPasswordText;

  /// No description provided for @pageChangePasswordConfirmPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get pageChangePasswordConfirmPasswordErrorText;

  /// No description provided for @pageChangePasswordMatchPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get pageChangePasswordMatchPasswordErrorText;

  /// No description provided for @pageChangePasswordShowDialogSuccessText.
  ///
  /// In en, this message translates to:
  /// **'Changed Password successfully !'**
  String get pageChangePasswordShowDialogSuccessText;

  /// No description provided for @pageChangePasswordShowDialogFailText.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get pageChangePasswordShowDialogFailText;

  /// No description provided for @pageChangePasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get pageChangePasswordErrorText;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set your new password'**
  String get changePasswordSubtitle;

  /// No description provided for @pageChangePasswordErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Old password and new password are same'**
  String get pageChangePasswordErrorMsg;

  /// No description provided for @pageTicketInfoEndButton.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get pageTicketInfoEndButton;

  /// No description provided for @pageDashBoardDataNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'DATA NOT AVAILABLE'**
  String get pageDashBoardDataNotAvailable;

  /// No description provided for @pageDashBoardNoOfAgentAssigned.
  ///
  /// In en, this message translates to:
  /// **'No of Agents Assigned'**
  String get pageDashBoardNoOfAgentAssigned;

  /// No description provided for @pageDashBoardAssignedChats.
  ///
  /// In en, this message translates to:
  /// **'Assigned \nchats'**
  String get pageDashBoardAssignedChats;

  /// No description provided for @pageDashBoardChatsInQueue.
  ///
  /// In en, this message translates to:
  /// **'Chats in \nQueue'**
  String get pageDashBoardChatsInQueue;

  /// No description provided for @pageDashBoardAvgSessionTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Session \nTime'**
  String get pageDashBoardAvgSessionTime;

  /// No description provided for @pageDashBoardMissedChats.
  ///
  /// In en, this message translates to:
  /// **'Missed Chats'**
  String get pageDashBoardMissedChats;

  /// No description provided for @pageDashBoardPatient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get pageDashBoardPatient;

  /// No description provided for @pageDashBoardAgent.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get pageDashBoardAgent;

  /// No description provided for @pageDashBoardStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get pageDashBoardStatus;

  /// No description provided for @pageDashBoardStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get pageDashBoardStartTime;

  /// No description provided for @pageDashBoardEndTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get pageDashBoardEndTime;

  /// No description provided for @pageDashBoardDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get pageDashBoardDuration;

  /// No description provided for @pageDashBoardFeedBack.
  ///
  /// In en, this message translates to:
  /// **'FeedBack'**
  String get pageDashBoardFeedBack;

  /// No description provided for @pageDashBoardSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get pageDashBoardSubject;

  /// No description provided for @pageDashBoardActiveAgents.
  ///
  /// In en, this message translates to:
  /// **'Active Agents'**
  String get pageDashBoardActiveAgents;

  /// No description provided for @pageDashBoardDashBoard.
  ///
  /// In en, this message translates to:
  /// **'DashBoard'**
  String get pageDashBoardDashBoard;

  /// No description provided for @pageDashBoardServingPatient.
  ///
  /// In en, this message translates to:
  /// **'Serving Patients'**
  String get pageDashBoardServingPatient;

  /// No description provided for @pageForgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get pageForgotPasswordSuccess;

  /// No description provided for @pageForgotPasswordResetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password reset successful!'**
  String get pageForgotPasswordResetSuccessfully;

  /// No description provided for @pageForgotPasswordBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get pageForgotPasswordBackToLogin;

  /// No description provided for @pageForgotPasswordSent.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get pageForgotPasswordSent;

  /// No description provided for @pageForgotPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get pageForgotPasswordError;

  /// No description provided for @pageForgotPasswordErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Email does not exist or there was an error resetting the password.'**
  String get pageForgotPasswordErrorMsg;

  /// No description provided for @pageLoginForgotPasswordPage.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get pageLoginForgotPasswordPage;

  /// No description provided for @pageProfileEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get pageProfileEmailAddress;

  /// No description provided for @pageProfilePleaseEnterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Email Address'**
  String get pageProfilePleaseEnterYourEmailAddress;

  /// No description provided for @pageLiveAgentAvgQueueTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Queue \nTime'**
  String get pageLiveAgentAvgQueueTime;

  /// No description provided for @pageLiveAgentAvgSessionTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Session Time'**
  String get pageLiveAgentAvgSessionTime;

  /// No description provided for @pageLiveAgentUaeCustomer.
  ///
  /// In en, this message translates to:
  /// **'UAE_customer '**
  String get pageLiveAgentUaeCustomer;

  /// No description provided for @pageLiveAgentStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get pageLiveAgentStatus;

  /// No description provided for @pageLiveAgentCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get pageLiveAgentCustomer;

  /// No description provided for @pageAgentManagerAgentList.
  ///
  /// In en, this message translates to:
  /// **'Agent List'**
  String get pageAgentManagerAgentList;

  /// No description provided for @pageAgentManagerSearchAgent.
  ///
  /// In en, this message translates to:
  /// **'Search Agent'**
  String get pageAgentManagerSearchAgent;

  /// No description provided for @pageAgentManagerNoAgentFound.
  ///
  /// In en, this message translates to:
  /// **'No Agent Found'**
  String get pageAgentManagerNoAgentFound;

  /// No description provided for @pageLiveConversationUserName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get pageLiveConversationUserName;

  /// No description provided for @pageLiveConversationRequestTime.
  ///
  /// In en, this message translates to:
  /// **'Request Time'**
  String get pageLiveConversationRequestTime;

  /// No description provided for @pageLiveConversationWaitingMins.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time (mm:ss)'**
  String get pageLiveConversationWaitingMins;

  /// No description provided for @pageLiveConversationCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get pageLiveConversationCategory;

  /// No description provided for @pageLiveConversationAgentName.
  ///
  /// In en, this message translates to:
  /// **'Agent Name'**
  String get pageLiveConversationAgentName;

  /// No description provided for @pageLiveConversationChatStartTime.
  ///
  /// In en, this message translates to:
  /// **'Chat Start Time'**
  String get pageLiveConversationChatStartTime;

  /// No description provided for @pageLiveConversationChatDuration.
  ///
  /// In en, this message translates to:
  /// **'Chat Duration'**
  String get pageLiveConversationChatDuration;

  /// No description provided for @pageMissingInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get pageMissingInfoMessage;

  /// No description provided for @pageMissingInfoReinitiateFlutter.
  ///
  /// In en, this message translates to:
  /// **'reinitiate flutter'**
  String get pageMissingInfoReinitiateFlutter;

  /// No description provided for @pageMissingInfoReinitiate.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate'**
  String get pageMissingInfoReinitiate;

  /// No description provided for @pageMissingInfoNoRecords.
  ///
  /// In en, this message translates to:
  /// **'No Records'**
  String get pageMissingInfoNoRecords;

  /// No description provided for @pageMissingInfoUnResolved.
  ///
  /// In en, this message translates to:
  /// **'Un Resolved'**
  String get pageMissingInfoUnResolved;

  /// No description provided for @pageMissingInfoRequestTime.
  ///
  /// In en, this message translates to:
  /// **'Request Time'**
  String get pageMissingInfoRequestTime;

  /// No description provided for @pageMissingInfoWaitingTime.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time'**
  String get pageMissingInfoWaitingTime;

  /// No description provided for @pageReportsScreenReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get pageReportsScreenReports;

  /// No description provided for @pageReportsScreenStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get pageReportsScreenStartTime;

  /// No description provided for @pageReportsScreenEndTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get pageReportsScreenEndTime;

  /// No description provided for @pageReportsScreenChatDurationMins.
  ///
  /// In en, this message translates to:
  /// **'Chat Duration (min)'**
  String get pageReportsScreenChatDurationMins;

  /// No description provided for @pageReportsFromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get pageReportsFromDate;

  /// No description provided for @pageReportsToDate.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get pageReportsToDate;

  /// No description provided for @pageReportsSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get pageReportsSubmit;

  /// No description provided for @pageReportsReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get pageReportsReports;

  /// No description provided for @pageAudioMessageToListenTheAudio.
  ///
  /// In en, this message translates to:
  /// **'To listen the audio file download it'**
  String get pageAudioMessageToListenTheAudio;

  /// No description provided for @pageIncomingMessageListReplyMessageType.
  ///
  /// In en, this message translates to:
  /// **'List Reply message Type'**
  String get pageIncomingMessageListReplyMessageType;

  /// No description provided for @pageIncomingMessageUnKnownMessageType.
  ///
  /// In en, this message translates to:
  /// **'Unknown message type'**
  String get pageIncomingMessageUnKnownMessageType;

  /// No description provided for @pageOtherMediaMessageToViewTheFileDownloadIt.
  ///
  /// In en, this message translates to:
  /// **'To view the file download it'**
  String get pageOtherMediaMessageToViewTheFileDownloadIt;

  /// No description provided for @pageOutgoingMessageCardOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get pageOutgoingMessageCardOptions;

  /// No description provided for @pageChatInputPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get pageChatInputPhoto;

  /// No description provided for @pageChatInputFile.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get pageChatInputFile;

  /// No description provided for @pageChatInputNewMessage.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get pageChatInputNewMessage;

  /// No description provided for @pageChatManagerSelectTicketToConversation.
  ///
  /// In en, this message translates to:
  /// **'Select ticket to conversation'**
  String get pageChatManagerSelectTicketToConversation;

  /// No description provided for @pageChatManagerNothingIsSelected.
  ///
  /// In en, this message translates to:
  /// **'Nothing is selected'**
  String get pageChatManagerNothingIsSelected;

  /// No description provided for @pageContactDetailsNoRoles.
  ///
  /// In en, this message translates to:
  /// **'No Roles'**
  String get pageContactDetailsNoRoles;

  /// No description provided for @pageContactDetailsNoAgents.
  ///
  /// In en, this message translates to:
  /// **'No Agents'**
  String get pageContactDetailsNoAgents;

  /// No description provided for @pageContactDetailsResolvedChats.
  ///
  /// In en, this message translates to:
  /// **'Resolve Chat'**
  String get pageContactDetailsResolvedChats;

  /// No description provided for @pageContactDetailsAreYouSureWantToResolveThisChat.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to resolve this chat ?'**
  String get pageContactDetailsAreYouSureWantToResolveThisChat;

  /// No description provided for @pageContactDetailsNoCategoryFound.
  ///
  /// In en, this message translates to:
  /// **'no category found'**
  String get pageContactDetailsNoCategoryFound;

  /// No description provided for @pageContactDEtailsNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get pageContactDEtailsNo;

  /// No description provided for @pageContactDetailsTransferTicket.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get pageContactDetailsTransferTicket;

  /// No description provided for @pageContactDetailsResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get pageContactDetailsResolved;

  /// No description provided for @pageContactDetailsAgent.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get pageContactDetailsAgent;

  /// No description provided for @pageContactDetailsDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pageContactDetailsDate;

  /// No description provided for @pageContactDetailsTicketsTransferBy.
  ///
  /// In en, this message translates to:
  /// **'Ticket Transfer By:'**
  String get pageContactDetailsTicketsTransferBy;

  /// No description provided for @pageTicketScreenSelectTicketToReadDetails.
  ///
  /// In en, this message translates to:
  /// **'Select ticket to read details'**
  String get pageTicketScreenSelectTicketToReadDetails;

  /// No description provided for @pageTicketScreenAtTheMomentNoTicketHave.
  ///
  /// In en, this message translates to:
  /// **'At the moment,no tickets have been assigned'**
  String get pageTicketScreenAtTheMomentNoTicketHave;

  /// No description provided for @pageTicketScreenPleaseSelectTokenToView.
  ///
  /// In en, this message translates to:
  /// **'Please select token to view'**
  String get pageTicketScreenPleaseSelectTokenToView;

  /// No description provided for @pageChatWidgetSelectTicketToConversation.
  ///
  /// In en, this message translates to:
  /// **'Please select ticket to conversation'**
  String get pageChatWidgetSelectTicketToConversation;

  /// No description provided for @pageChatWidgetNothingIsSelected.
  ///
  /// In en, this message translates to:
  /// **'Nothing is selected'**
  String get pageChatWidgetNothingIsSelected;

  /// No description provided for @pageTicketManagerSelectTicketToReadDetails.
  ///
  /// In en, this message translates to:
  /// **'Select ticket to read details'**
  String get pageTicketManagerSelectTicketToReadDetails;

  /// No description provided for @pageContactDetailsNoTicketsFound.
  ///
  /// In en, this message translates to:
  /// **'No Tickets Found'**
  String get pageContactDetailsNoTicketsFound;

  /// No description provided for @pageAgentManagerAgentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Agent not found'**
  String get pageAgentManagerAgentNotFound;

  /// No description provided for @pageAgentManagerSearchAgents.
  ///
  /// In en, this message translates to:
  /// **'Search Agent'**
  String get pageAgentManagerSearchAgents;

  /// No description provided for @pageAgentManagerAgentsList.
  ///
  /// In en, this message translates to:
  /// **'Agents List'**
  String get pageAgentManagerAgentsList;

  /// No description provided for @pageAgentDetailsAssignedChats.
  ///
  /// In en, this message translates to:
  /// **'Assigned Chats'**
  String get pageAgentDetailsAssignedChats;

  /// No description provided for @pageAgentDetailsTotalChats.
  ///
  /// In en, this message translates to:
  /// **'Total chats'**
  String get pageAgentDetailsTotalChats;

  /// No description provided for @pageAgentDetailsAvgQueueTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Queue  \nTime'**
  String get pageAgentDetailsAvgQueueTime;

  /// No description provided for @pageAgentDetailsMaxQueue.
  ///
  /// In en, this message translates to:
  /// **'MaxQueue  \nTime'**
  String get pageAgentDetailsMaxQueue;

  /// No description provided for @pageAgentDetailsAvgSessionTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Conversation Time'**
  String get pageAgentDetailsAvgSessionTime;

  /// No description provided for @pageAgentDetailsUaeCustomer.
  ///
  /// In en, this message translates to:
  /// **'UAE_customer '**
  String get pageAgentDetailsUaeCustomer;

  /// No description provided for @pageAgentDetailsCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get pageAgentDetailsCustomer;

  /// No description provided for @pageAgentDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status :'**
  String get pageAgentDetailsStatus;

  /// No description provided for @pageLiveAgentSelectAgentToRead.
  ///
  /// In en, this message translates to:
  /// **'Select agent to read'**
  String get pageLiveAgentSelectAgentToRead;

  /// No description provided for @pageLiveConversationChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get pageLiveConversationChat;

  /// No description provided for @pageLiveConversationsUserName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get pageLiveConversationsUserName;

  /// No description provided for @pageLiveConversationREquestTime.
  ///
  /// In en, this message translates to:
  /// **'Request Time'**
  String get pageLiveConversationREquestTime;

  /// No description provided for @pageLiveConversationWaitingTimeInMin.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time \n(mm:ss)'**
  String get pageLiveConversationWaitingTimeInMin;

  /// No description provided for @pageLiveConversationsCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get pageLiveConversationsCategory;

  /// No description provided for @pageLiveConversationsAgentName.
  ///
  /// In en, this message translates to:
  /// **'Agent Name'**
  String get pageLiveConversationsAgentName;

  /// No description provided for @pageLiveConversationsChatStartTime.
  ///
  /// In en, this message translates to:
  /// **'Chat Start Time'**
  String get pageLiveConversationsChatStartTime;

  /// No description provided for @pageLiveConversationsChatDuration.
  ///
  /// In en, this message translates to:
  /// **'Chat Duration'**
  String get pageLiveConversationsChatDuration;

  /// No description provided for @pageMissingInfoOk.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get pageMissingInfoOk;

  /// No description provided for @pageContactDetailsConstDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get pageContactDetailsConstDetails;

  /// No description provided for @pageContactDetailsUserMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'User Number: '**
  String get pageContactDetailsUserMobileNumber;

  /// No description provided for @pageContactDetailsProfileName.
  ///
  /// In en, this message translates to:
  /// **'Profile Name: '**
  String get pageContactDetailsProfileName;

  /// No description provided for @pageContactDetailsComments.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get pageContactDetailsComments;

  /// No description provided for @pageContactDetailsDates.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pageContactDetailsDates;

  /// No description provided for @pageContactDetailsAgents.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get pageContactDetailsAgents;

  /// No description provided for @pageTicketScreenAtTheMomentNoTickets.
  ///
  /// In en, this message translates to:
  /// **'At the moment,no tickets have been assigned'**
  String get pageTicketScreenAtTheMomentNoTickets;

  /// No description provided for @pageTicketsScreenPleaseSelectTokenToView.
  ///
  /// In en, this message translates to:
  /// **'Please select token to view'**
  String get pageTicketsScreenPleaseSelectTokenToView;

  /// No description provided for @pageTicketManagerTicketNumber.
  ///
  /// In en, this message translates to:
  /// **'Ticket No :'**
  String get pageTicketManagerTicketNumber;

  /// No description provided for @pageSocketStatusDoYouWantToUpdateTheStatus.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update the status of the agent ?'**
  String get pageSocketStatusDoYouWantToUpdateTheStatus;

  /// No description provided for @pageChatStaticPendingQueueCount.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pageChatStaticPendingQueueCount;

  /// No description provided for @pageModelBottomSheetPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get pageModelBottomSheetPhoto;

  /// No description provided for @pageModelBottomSheetFile.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get pageModelBottomSheetFile;

  /// No description provided for @pageModelBottomSheetCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get pageModelBottomSheetCancel;

  /// No description provided for @pageLiveConversationNoRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No Records Found '**
  String get pageLiveConversationNoRecordsFound;

  /// No description provided for @pageMissingChatsNoRecordsFoundForSearch.
  ///
  /// In en, this message translates to:
  /// **'No Records Found For Search'**
  String get pageMissingChatsNoRecordsFoundForSearch;

  /// No description provided for @pageLiveConversationLiveConversation.
  ///
  /// In en, this message translates to:
  /// **'Live Conversation'**
  String get pageLiveConversationLiveConversation;

  /// No description provided for @pageStaticsBarAssignedChats.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get pageStaticsBarAssignedChats;

  /// No description provided for @pageStaticsBarTotalChats.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get pageStaticsBarTotalChats;

  /// No description provided for @pageStaticsBarPriorityToken.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get pageStaticsBarPriorityToken;

  /// No description provided for @pageMissingInformationDropdownItem.
  ///
  /// In en, this message translates to:
  /// **'NONWORKING'**
  String get pageMissingInformationDropdownItem;

  /// No description provided for @pageMissingInformationDropdownItemPending.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pageMissingInformationDropdownItemPending;

  /// No description provided for @pageMissingInformationDropdownItemUnassigned.
  ///
  /// In en, this message translates to:
  /// **'UNASSIGNED'**
  String get pageMissingInformationDropdownItemUnassigned;

  /// No description provided for @pageMissingInformationDropdownItemUnresolved.
  ///
  /// In en, this message translates to:
  /// **'UNRESOLVED'**
  String get pageMissingInformationDropdownItemUnresolved;

  /// No description provided for @pageAgentCardAgentName.
  ///
  /// In en, this message translates to:
  /// **'Agent name '**
  String get pageAgentCardAgentName;

  /// No description provided for @pageAgentCardEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Id '**
  String get pageAgentCardEmail;

  /// No description provided for @pageAgentCardMobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile no '**
  String get pageAgentCardMobileNo;

  /// No description provided for @pageAgentCardCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name '**
  String get pageAgentCardCustomerName;

  /// No description provided for @pageAgentCardAssignedChats.
  ///
  /// In en, this message translates to:
  /// **'Assigned\nChats '**
  String get pageAgentCardAssignedChats;

  /// No description provided for @pageAgentCardTotalChats.
  ///
  /// In en, this message translates to:
  /// **'Total Chats '**
  String get pageAgentCardTotalChats;

  /// No description provided for @pageAgentCardAvgSessionTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Session\nTime '**
  String get pageAgentCardAvgSessionTime;

  /// No description provided for @pageAgentCardAvgQueueTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Queue\nTime '**
  String get pageAgentCardAvgQueueTime;

  /// No description provided for @pageChatInputAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get pageChatInputAudio;

  /// No description provided for @pageChatInputLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get pageChatInputLocation;

  /// No description provided for @pageBottomSheetDocument.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get pageBottomSheetDocument;

  /// No description provided for @pageChatInputGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get pageChatInputGallery;

  /// No description provided for @pageMissingInformation.
  ///
  /// In en, this message translates to:
  /// **'Username :'**
  String get pageMissingInformation;

  /// No description provided for @pageMissingInformationRequestTime.
  ///
  /// In en, this message translates to:
  /// **'Request Time'**
  String get pageMissingInformationRequestTime;

  /// No description provided for @pageMissingInformationCategory.
  ///
  /// In en, this message translates to:
  /// **'Category '**
  String get pageMissingInformationCategory;

  /// No description provided for @pageMissingInformationWaitingTime.
  ///
  /// In en, this message translates to:
  /// **'Waiting time'**
  String get pageMissingInformationWaitingTime;

  /// No description provided for @pageMissingInformationReinitiate.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate:'**
  String get pageMissingInformationReinitiate;

  /// No description provided for @pageProfileLanguagesEnglishArabic.
  ///
  /// In en, this message translates to:
  /// **'English,Arabic'**
  String get pageProfileLanguagesEnglishArabic;

  /// No description provided for @pageBottomSheetCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get pageBottomSheetCamera;

  /// No description provided for @pageLiveConversationAgentNames.
  ///
  /// In en, this message translates to:
  /// **'Agent Name '**
  String get pageLiveConversationAgentNames;

  /// No description provided for @pageLiveConversationChatDurations.
  ///
  /// In en, this message translates to:
  /// **'Chat Duration'**
  String get pageLiveConversationChatDurations;

  /// No description provided for @pageLiveConversationsStartingTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time '**
  String get pageLiveConversationsStartingTime;

  /// No description provided for @pageLiveConversationStartingChat.
  ///
  /// In en, this message translates to:
  /// **'Chat Start: '**
  String get pageLiveConversationStartingChat;

  /// No description provided for @pageAgentDetailsChatsInQueue.
  ///
  /// In en, this message translates to:
  /// **'Chats in \nQueue'**
  String get pageAgentDetailsChatsInQueue;

  /// No description provided for @pageAgentDetailsAssigningChats.
  ///
  /// In en, this message translates to:
  /// **'Assigned \nChats'**
  String get pageAgentDetailsAssigningChats;

  /// No description provided for @pageLiveAgentNoRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No Records Found'**
  String get pageLiveAgentNoRecordsFound;

  /// No description provided for @pageLiveConversationsComments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get pageLiveConversationsComments;

  /// No description provided for @pageLiveConversationsStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time '**
  String get pageLiveConversationsStartTime;

  /// No description provided for @pageLiveConversationChatTime.
  ///
  /// In en, this message translates to:
  /// **'Chat Time '**
  String get pageLiveConversationChatTime;

  /// No description provided for @pageMissingConversationCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get pageMissingConversationCategory;

  /// No description provided for @pageMissingConversationWaitingTime.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time'**
  String get pageMissingConversationWaitingTime;

  /// No description provided for @pageMissingConversationReinitiate.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate'**
  String get pageMissingConversationReinitiate;

  /// No description provided for @pageChangePasswordCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get pageChangePasswordCurrentPassword;

  /// No description provided for @pageChangePasswordNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get pageChangePasswordNewPassword;

  /// No description provided for @pageChangePasswordConformPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get pageChangePasswordConformPassword;

  /// No description provided for @pageChangePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get pageChangePasswordSuccess;

  /// No description provided for @pageChangePasswordSuccessfullyChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully.'**
  String get pageChangePasswordSuccessfullyChangePassword;

  /// No description provided for @pageChangePasswordFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get pageChangePasswordFailed;

  /// No description provided for @pageChangePasswordFailedToChangeThePassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get pageChangePasswordFailedToChangeThePassword;

  /// No description provided for @pageSystemLogoutSorryYourSessionHasLogout.
  ///
  /// In en, this message translates to:
  /// **'Sorry,Your Session has Logout'**
  String get pageSystemLogoutSorryYourSessionHasLogout;

  /// No description provided for @pageSystemLogoutSomeoneIsTryingToLogin.
  ///
  /// In en, this message translates to:
  /// **'Someone is trying to Login with our Account,Thats why \nyour session has Logout.'**
  String get pageSystemLogoutSomeoneIsTryingToLogin;

  /// No description provided for @pageSystemLogoutGoToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get pageSystemLogoutGoToLogin;

  /// No description provided for @pageOtherMediaMsg.
  ///
  /// In en, this message translates to:
  /// **'To view the file download it'**
  String get pageOtherMediaMsg;

  /// No description provided for @pageOutgoingMsgtapToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap to select text'**
  String get pageOutgoingMsgtapToSelect;

  /// No description provided for @pageChatInputNewMsg.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get pageChatInputNewMsg;

  /// No description provided for @pageContactDetailsPleaseEnterSomeText.
  ///
  /// In en, this message translates to:
  /// **'please enter some text'**
  String get pageContactDetailsPleaseEnterSomeText;

  /// No description provided for @pageTicketScreenPleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pageTicketScreenPleaseSelectCategory;

  /// No description provided for @pageTicketScreenPleaseEnterAComment.
  ///
  /// In en, this message translates to:
  /// **'Please enter a comment'**
  String get pageTicketScreenPleaseEnterAComment;

  /// No description provided for @pageTicketScreenContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get pageTicketScreenContact;

  /// No description provided for @pageForgotPasswordString.
  ///
  /// In en, this message translates to:
  /// **'Password sent to email successfully'**
  String get pageForgotPasswordString;

  /// No description provided for @pageSocketStatusOfflineHintText.
  ///
  /// In en, this message translates to:
  /// **'Please Enter The Reason For Offline Status Updation'**
  String get pageSocketStatusOfflineHintText;

  /// No description provided for @menuTicket.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get menuTicket;

  /// No description provided for @menuLiveAgent.
  ///
  /// In en, this message translates to:
  /// **'Live Agent'**
  String get menuLiveAgent;

  /// No description provided for @menuMissingInfo.
  ///
  /// In en, this message translates to:
  /// **'Missing Information'**
  String get menuMissingInfo;

  /// No description provided for @menuLiveConversation.
  ///
  /// In en, this message translates to:
  /// **'Live Conversation'**
  String get menuLiveConversation;

  /// No description provided for @menuProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get menuProfile;

  /// No description provided for @menuChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get menuChangePassword;

  /// No description provided for @menuProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile Image'**
  String get menuProfileImage;

  /// No description provided for @menuChangeBackground.
  ///
  /// In en, this message translates to:
  /// **'Change Background'**
  String get menuChangeBackground;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @noRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No Records Found'**
  String get noRecordsFound;

  /// No description provided for @enterFiveAtLeastFiveCharacter.
  ///
  /// In en, this message translates to:
  /// **'Enter atleast 5 Character'**
  String get enterFiveAtLeastFiveCharacter;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @pleaseSelectReason.
  ///
  /// In en, this message translates to:
  /// **'Please Select Reason'**
  String get pleaseSelectReason;

  /// No description provided for @pageMissingInfoDataTableGroupCode.
  ///
  /// In en, this message translates to:
  /// **'Group Code'**
  String get pageMissingInfoDataTableGroupCode;

  /// No description provided for @pTicketManagerGeneral.
  ///
  /// In en, this message translates to:
  /// **'(General)'**
  String get pTicketManagerGeneral;

  /// No description provided for @pTicketDetailsUserDetails.
  ///
  /// In en, this message translates to:
  /// **'User Details'**
  String get pTicketDetailsUserDetails;

  /// No description provided for @pTicketDetailsLanguages.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get pTicketDetailsLanguages;

  /// No description provided for @pTicketDetailsPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get pTicketDetailsPriority;

  /// No description provided for @pTicketDetailsGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get pTicketDetailsGroup;

  /// No description provided for @pTicketScreenMobileLayout.
  ///
  /// In en, this message translates to:
  /// **'Profile Name'**
  String get pTicketScreenMobileLayout;

  /// No description provided for @pTicketScreenMobileLayoutTicketInfo.
  ///
  /// In en, this message translates to:
  /// **'User info'**
  String get pTicketScreenMobileLayoutTicketInfo;

  /// No description provided for @pProfile.
  ///
  /// In en, this message translates to:
  /// **'Languages Known:'**
  String get pProfile;

  /// No description provided for @pTicketScreenMobileLayoutSubCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Subcategory'**
  String get pTicketScreenMobileLayoutSubCategory;

  /// No description provided for @pChatWidgetChatSyncIsInProgress.
  ///
  /// In en, this message translates to:
  /// **'Chat sync is in progress, and this may take some time'**
  String get pChatWidgetChatSyncIsInProgress;

  /// No description provided for @pSocketStatusWidgetChatServerIsConnecting.
  ///
  /// In en, this message translates to:
  /// **'connecting'**
  String get pSocketStatusWidgetChatServerIsConnecting;

  /// No description provided for @pSocketStatusWidgetChatServerIsConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get pSocketStatusWidgetChatServerIsConnected;

  /// No description provided for @pSocketStatusWidgetChatServerIsDisConnecting.
  ///
  /// In en, this message translates to:
  /// **'disconnecting'**
  String get pSocketStatusWidgetChatServerIsDisConnecting;

  /// No description provided for @pSocketStatusWidgetChatServerIsDisConnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get pSocketStatusWidgetChatServerIsDisConnected;

  /// No description provided for @pSocketStatusWidgetBreak.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get pSocketStatusWidgetBreak;

  /// No description provided for @pSocketStatusWidgetLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get pSocketStatusWidgetLunch;

  /// No description provided for @pSocketStatusWidgetMeeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get pSocketStatusWidgetMeeting;

  /// No description provided for @pSocketStatusWidgetMedical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get pSocketStatusWidgetMedical;

  /// No description provided for @pSocketStatusWidgetPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get pSocketStatusWidgetPrayer;

  /// No description provided for @pSocketStatusWidgetOthers.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get pSocketStatusWidgetOthers;

  /// No description provided for @pLiveAgentSelectAgentToRead.
  ///
  /// In en, this message translates to:
  /// **'Select Agent To Read Details'**
  String get pLiveAgentSelectAgentToRead;

  /// No description provided for @pAgentDetailsHoursMinsSeconds.
  ///
  /// In en, this message translates to:
  /// **'(hh:mm:ss)'**
  String get pAgentDetailsHoursMinsSeconds;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @conversationStartHere.
  ///
  /// In en, this message translates to:
  /// **'Conversation start here'**
  String get conversationStartHere;

  /// No description provided for @testTemplate.
  ///
  /// In en, this message translates to:
  /// **'Test template'**
  String get testTemplate;

  /// No description provided for @psSocketStatusWidgetChatServerIsConnecting.
  ///
  /// In en, this message translates to:
  /// **'Chat server is connecting'**
  String get psSocketStatusWidgetChatServerIsConnecting;

  /// No description provided for @psSocketStatusWidgetChatServerIsConnected.
  ///
  /// In en, this message translates to:
  /// **'Chat server is Connected'**
  String get psSocketStatusWidgetChatServerIsConnected;

  /// No description provided for @psSocketStatusWidgetChatServerIsDisConnecting.
  ///
  /// In en, this message translates to:
  /// **'Chat server is disconnecting'**
  String get psSocketStatusWidgetChatServerIsDisConnecting;

  /// No description provided for @psSocketStatusWidgetChatServerIsDisConnected.
  ///
  /// In en, this message translates to:
  /// **'Chat server is Disconnected'**
  String get psSocketStatusWidgetChatServerIsDisConnected;

  /// No description provided for @chatBox.
  ///
  /// In en, this message translates to:
  /// **'My Chats'**
  String get chatBox;

  /// No description provided for @hourMinuteSeconds.
  ///
  /// In en, this message translates to:
  /// **'hh:mm:ss'**
  String get hourMinuteSeconds;

  /// No description provided for @vAgent.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get vAgent;

  /// No description provided for @vAgentAdmin.
  ///
  /// In en, this message translates to:
  /// **'Agent Admin'**
  String get vAgentAdmin;

  /// No description provided for @vAgentSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Agent Supervisor'**
  String get vAgentSupervisor;

  /// No description provided for @pleaseSelectTokenToView.
  ///
  /// In en, this message translates to:
  /// **'Please Select Token to View'**
  String get pleaseSelectTokenToView;

  /// No description provided for @userNumber.
  ///
  /// In en, this message translates to:
  /// **'User number :'**
  String get userNumber;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Profile Name :'**
  String get profileName;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @editProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Image'**
  String get editProfileImage;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message'**
  String get typeAMessage;

  /// No description provided for @noMessagehereYet.
  ///
  /// In en, this message translates to:
  /// **'No Message here yet'**
  String get noMessagehereYet;

  /// No description provided for @closeChat.
  ///
  /// In en, this message translates to:
  /// **'Close Chat'**
  String get closeChat;

  /// No description provided for @closeChatQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to close this chat ?'**
  String get closeChatQuestion;

  /// No description provided for @sendTemplate.
  ///
  /// In en, this message translates to:
  /// **'Send Template'**
  String get sendTemplate;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// No description provided for @enterFive.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 5 characters'**
  String get enterFive;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @pleaseSelectTags.
  ///
  /// In en, this message translates to:
  /// **'Please select tags'**
  String get pleaseSelectTags;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @noCommentsFound.
  ///
  /// In en, this message translates to:
  /// **'No Comments Found'**
  String get noCommentsFound;

  /// No description provided for @pleaseSelectAgent.
  ///
  /// In en, this message translates to:
  /// **'Please Select agent'**
  String get pleaseSelectAgent;

  /// No description provided for @groupName.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get groupName;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @reinitiate.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate'**
  String get reinitiate;

  /// No description provided for @liveAgent.
  ///
  /// In en, this message translates to:
  /// **'Live Agent'**
  String get liveAgent;

  /// No description provided for @missingInformation.
  ///
  /// In en, this message translates to:
  /// **'Missing Information'**
  String get missingInformation;

  /// No description provided for @liveConversation.
  ///
  /// In en, this message translates to:
  /// **'Live Conversation'**
  String get liveConversation;

  /// No description provided for @closes.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closes;

  /// No description provided for @preView.
  ///
  /// In en, this message translates to:
  /// **'PreView'**
  String get preView;

  /// No description provided for @selectInteractiveTemplate.
  ///
  /// In en, this message translates to:
  /// **'Select Interactive Template'**
  String get selectInteractiveTemplate;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update the status ?'**
  String get updateStatus;

  /// No description provided for @chatsInQueue.
  ///
  /// In en, this message translates to:
  /// **'Chats In Queue'**
  String get chatsInQueue;

  /// No description provided for @totalChats.
  ///
  /// In en, this message translates to:
  /// **'Total Chats'**
  String get totalChats;

  /// No description provided for @avgConversationTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Conversation Time'**
  String get avgConversationTime;

  /// No description provided for @agentName.
  ///
  /// In en, this message translates to:
  /// **'Agent Name'**
  String get agentName;

  /// No description provided for @assignTicket.
  ///
  /// In en, this message translates to:
  /// **'Assign Ticket'**
  String get assignTicket;

  /// No description provided for @viewChatHistory.
  ///
  /// In en, this message translates to:
  /// **'View Chat history'**
  String get viewChatHistory;

  /// No description provided for @pageStaticsBarAssignedChat.
  ///
  /// In en, this message translates to:
  /// **'Total Tickets Count'**
  String get pageStaticsBarAssignedChat;

  /// No description provided for @pageStaticsBarTotalChat.
  ///
  /// In en, this message translates to:
  /// **'Resolved Count'**
  String get pageStaticsBarTotalChat;

  /// No description provided for @pageStaticsBarPriorityToke.
  ///
  /// In en, this message translates to:
  /// **'Priority Tickets Count'**
  String get pageStaticsBarPriorityToke;

  /// No description provided for @pageChatStaticPendingQueueCoun.
  ///
  /// In en, this message translates to:
  /// **'Pending Queue Count'**
  String get pageChatStaticPendingQueueCoun;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @maxFiftyCharactersAreAllowed.
  ///
  /// In en, this message translates to:
  /// **'Max 50 characters are allowed'**
  String get maxFiftyCharactersAreAllowed;

  /// No description provided for @currentMissingInformation.
  ///
  /// In en, this message translates to:
  /// **'Current Missing Information'**
  String get currentMissingInformation;

  /// No description provided for @pastMissingInformation.
  ///
  /// In en, this message translates to:
  /// **'Past Missing Information'**
  String get pastMissingInformation;

  /// No description provided for @reinitiates.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate'**
  String get reinitiates;

  /// No description provided for @submitYourRequestToViewData.
  ///
  /// In en, this message translates to:
  /// **'Submit your request to view data'**
  String get submitYourRequestToViewData;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'submit'**
  String get submit;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @lastThreeDays.
  ///
  /// In en, this message translates to:
  /// **'Last 3 Days'**
  String get lastThreeDays;

  /// No description provided for @lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last Week'**
  String get lastWeek;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// No description provided for @lastTwoMonth.
  ///
  /// In en, this message translates to:
  /// **'Last 2 Months'**
  String get lastTwoMonth;

  /// No description provided for @lastThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'Last 3 months'**
  String get lastThreeMonths;

  /// No description provided for @customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom Range'**
  String get customRange;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @nonWorking.
  ///
  /// In en, this message translates to:
  /// **'Non Working'**
  String get nonWorking;

  /// No description provided for @unResolved.
  ///
  /// In en, this message translates to:
  /// **'unResolved'**
  String get unResolved;

  /// No description provided for @unAssigned.
  ///
  /// In en, this message translates to:
  /// **'unAssigned'**
  String get unAssigned;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @pleaseEnterYourRemarks.
  ///
  /// In en, this message translates to:
  /// **'Please enter your remarks'**
  String get pleaseEnterYourRemarks;

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get contactDetails;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get comments;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get reports;

  /// No description provided for @conversationReports.
  ///
  /// In en, this message translates to:
  /// **'Conversation Reports'**
  String get conversationReports;

  /// No description provided for @conversationDetailedReports.
  ///
  /// In en, this message translates to:
  /// **'Conversation Detailed Reports'**
  String get conversationDetailedReports;

  /// No description provided for @combineAnalyticsReports.
  ///
  /// In en, this message translates to:
  /// **'Combine Analytics Reports'**
  String get combineAnalyticsReports;

  /// No description provided for @conversationDetailedReportsByMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Conversation Detailed Reports By Mobile Number'**
  String get conversationDetailedReportsByMobileNumber;

  /// No description provided for @missedChats.
  ///
  /// In en, this message translates to:
  /// **'Missed Chats'**
  String get missedChats;

  /// No description provided for @liveChats.
  ///
  /// In en, this message translates to:
  /// **'Live Chats'**
  String get liveChats;

  /// No description provided for @closedChats.
  ///
  /// In en, this message translates to:
  /// **'Closed Chats'**
  String get closedChats;

  /// No description provided for @myChats.
  ///
  /// In en, this message translates to:
  /// **'My Chats'**
  String get myChats;

  /// No description provided for @chatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get chatHistory;

  /// No description provided for @categorys.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categorys;

  /// No description provided for @mobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNo;

  /// No description provided for @noCategoryFound.
  ///
  /// In en, this message translates to:
  /// **'No category found'**
  String get noCategoryFound;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'SUCCESS'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'ERROR'**
  String get error;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @directoryDetails.
  ///
  /// In en, this message translates to:
  /// **'Directory Details'**
  String get directoryDetails;

  /// No description provided for @transferBy.
  ///
  /// In en, this message translates to:
  /// **'Transfer By'**
  String get transferBy;

  /// No description provided for @noVisits.
  ///
  /// In en, this message translates to:
  /// **'No Visits'**
  String get noVisits;

  /// No description provided for @lastTag.
  ///
  /// In en, this message translates to:
  /// **'Last Tag'**
  String get lastTag;

  /// No description provided for @totalWaitTime.
  ///
  /// In en, this message translates to:
  /// **'Total Wait Time'**
  String get totalWaitTime;

  /// No description provided for @chatStartTime.
  ///
  /// In en, this message translates to:
  /// **'Chat Start Time'**
  String get chatStartTime;

  /// No description provided for @chatEndTime.
  ///
  /// In en, this message translates to:
  /// **'Chat End Time'**
  String get chatEndTime;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @previousConversationAgent.
  ///
  /// In en, this message translates to:
  /// **'Previous Conversation Agent'**
  String get previousConversationAgent;

  /// No description provided for @selectTypeOfAgent.
  ///
  /// In en, this message translates to:
  /// **'Select Type of Agent'**
  String get selectTypeOfAgent;

  /// No description provided for @timeFormat.
  ///
  /// In en, this message translates to:
  /// **'hh:mm:ss'**
  String get timeFormat;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'dd/MM/yyyy'**
  String get dateFormat;

  /// No description provided for @timeFormat24.
  ///
  /// In en, this message translates to:
  /// **'HH:mm:ss'**
  String get timeFormat24;

  /// No description provided for @dateTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'yyyy-MM-dd HH:mm:ss'**
  String get dateTimeFormat;

  /// No description provided for @selectAgent.
  ///
  /// In en, this message translates to:
  /// **'Select Agent'**
  String get selectAgent;

  /// No description provided for @selectGroup.
  ///
  /// In en, this message translates to:
  /// **'Select Group'**
  String get selectGroup;

  /// No description provided for @selectAgentCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select category'**
  String get selectAgentCategory;

  /// No description provided for @activeSessionsHint.
  ///
  /// In en, this message translates to:
  /// **'Active Sessions: {count}'**
  String activeSessionsHint(Object count);

  /// No description provided for @languagesKnownHint.
  ///
  /// In en, this message translates to:
  /// **'Languages Known: {languages}'**
  String languagesKnownHint(Object languages);

  /// No description provided for @groupCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Group Code: {code}'**
  String groupCodeHint(Object code);

  /// No description provided for @agentInfoFormat.
  ///
  /// In en, this message translates to:
  /// **'{name} (Active Sessions: {sessions}, Languages Known: {languages}, Group Code: {code})'**
  String agentInfoFormat(Object code, Object languages, Object name, Object sessions);

  /// No description provided for @pleaseSelectAgentToTransfer.
  ///
  /// In en, this message translates to:
  /// **'Please select agent to transfer'**
  String get pleaseSelectAgentToTransfer;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @transferWarning.
  ///
  /// In en, this message translates to:
  /// **'This will transfer the ticket to another agent'**
  String get transferWarning;

  /// No description provided for @waitingTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'{minutes}:{seconds}'**
  String waitingTimeFormat(Object minutes, Object seconds);

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get general;

  /// No description provided for @vip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get vip;

  /// No description provided for @prime.
  ///
  /// In en, this message translates to:
  /// **'PRIME'**
  String get prime;

  /// No description provided for @vizag.
  ///
  /// In en, this message translates to:
  /// **'VIZAG'**
  String get vizag;

  /// No description provided for @durationFormat.
  ///
  /// In en, this message translates to:
  /// **'{hours}:{minutes}:{seconds}'**
  String durationFormat(Object hours, Object minutes, Object seconds);

  /// No description provided for @ticketNo.
  ///
  /// In en, this message translates to:
  /// **'Ticket No : '**
  String get ticketNo;

  /// No description provided for @answeredBy.
  ///
  /// In en, this message translates to:
  /// **'Answered By : '**
  String get answeredBy;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date :'**
  String get endDate;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date :'**
  String get startDate;

  /// No description provided for @chatsAssignable.
  ///
  /// In en, this message translates to:
  /// **'Chats Assignable: {count}'**
  String chatsAssignable(int count);

  /// No description provided for @agentLabelWithGroup.
  ///
  /// In en, this message translates to:
  /// **'Agent: {groupName}'**
  String agentLabelWithGroup(String groupName);

  /// No description provided for @roleAgent.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get roleAgent;

  /// No description provided for @roleAgentAdmin.
  ///
  /// In en, this message translates to:
  /// **'Agent Admin'**
  String get roleAgentAdmin;

  /// No description provided for @roleMasterAdmin.
  ///
  /// In en, this message translates to:
  /// **'Master Admin'**
  String get roleMasterAdmin;

  /// No description provided for @roleOthers.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get roleOthers;

  /// No description provided for @noAgentsFound.
  ///
  /// In en, this message translates to:
  /// **'No agents found'**
  String get noAgentsFound;

  /// No description provided for @tag.
  ///
  /// In en, this message translates to:
  /// **'Tag :'**
  String get tag;

  /// No description provided for @previousAgent.
  ///
  /// In en, this message translates to:
  /// **'Previous Agent :'**
  String get previousAgent;

  /// No description provided for @replyMessage.
  ///
  /// In en, this message translates to:
  /// **'Reply message'**
  String get replyMessage;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hi, Welcome to Live Agent'**
  String get welcomeMessage;

  /// No description provided for @solutionLine.
  ///
  /// In en, this message translates to:
  /// **'Ultimate solution for providing excellent customer support'**
  String get solutionLine;

  /// No description provided for @totalRequest.
  ///
  /// In en, this message translates to:
  /// **'Total Requests'**
  String get totalRequest;

  /// No description provided for @agentConversation.
  ///
  /// In en, this message translates to:
  /// **'Agent Conversations'**
  String get agentConversation;

  /// No description provided for @processingTickets.
  ///
  /// In en, this message translates to:
  /// **'Processing Tickets'**
  String get processingTickets;

  /// No description provided for @pendingTickets.
  ///
  /// In en, this message translates to:
  /// **'Pending Tickets'**
  String get pendingTickets;

  /// No description provided for @missingTickets.
  ///
  /// In en, this message translates to:
  /// **'Missing Tickets'**
  String get missingTickets;

  /// No description provided for @renitiateTickets.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate Tickets'**
  String get renitiateTickets;

  /// No description provided for @timeOfAssignment.
  ///
  /// In en, this message translates to:
  /// **'Time of Assignment'**
  String get timeOfAssignment;

  /// No description provided for @lastNotificationPriority.
  ///
  /// In en, this message translates to:
  /// **'Last Notification Priority'**
  String get lastNotificationPriority;

  /// No description provided for @wabaAccountDetails.
  ///
  /// In en, this message translates to:
  /// **'Waba Account details'**
  String get wabaAccountDetails;

  /// No description provided for @selectTemplate.
  ///
  /// In en, this message translates to:
  /// **'Select template'**
  String get selectTemplate;

  /// No description provided for @senderPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Sender phone number'**
  String get senderPhoneNumber;

  /// No description provided for @recipient.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get recipient;

  /// No description provided for @smartUrlConversion.
  ///
  /// In en, this message translates to:
  /// **'Smart url conversion'**
  String get smartUrlConversion;

  /// No description provided for @bodyAttribute.
  ///
  /// In en, this message translates to:
  /// **'Body Attribute'**
  String get bodyAttribute;

  /// No description provided for @headerAttribute.
  ///
  /// In en, this message translates to:
  /// **'Header Attribute'**
  String get headerAttribute;

  /// No description provided for @quickToReplyPayload.
  ///
  /// In en, this message translates to:
  /// **'Quick to reply payload'**
  String get quickToReplyPayload;

  /// No description provided for @retryAttemptFailedForTestTemplate.
  ///
  /// In en, this message translates to:
  /// **'Retry Attempt For Failed Template Test'**
  String get retryAttemptFailedForTestTemplate;

  /// No description provided for @additionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Additional information'**
  String get additionalInformation;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'ADD'**
  String get add;

  /// No description provided for @previewTemplate.
  ///
  /// In en, this message translates to:
  /// **'Preview Template'**
  String get previewTemplate;

  /// No description provided for @retryCount.
  ///
  /// In en, this message translates to:
  /// **'Retry Count'**
  String get retryCount;

  /// No description provided for @enterValue.
  ///
  /// In en, this message translates to:
  /// **'Enter Value'**
  String get enterValue;

  /// No description provided for @enterKey.
  ///
  /// In en, this message translates to:
  /// **'Enter Key'**
  String get enterKey;

  /// No description provided for @chooseTemplate.
  ///
  /// In en, this message translates to:
  /// **'Choose a template'**
  String get chooseTemplate;

  /// No description provided for @searchTemplate.
  ///
  /// In en, this message translates to:
  /// **'Search Template'**
  String get searchTemplate;

  /// No description provided for @selectSender.
  ///
  /// In en, this message translates to:
  /// **'Select sender'**
  String get selectSender;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'( Required )'**
  String get requiredField;

  /// No description provided for @enterHere.
  ///
  /// In en, this message translates to:
  /// **'Enter Here'**
  String get enterHere;

  /// No description provided for @callToActionConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Call To Action Configuration'**
  String get callToActionConfiguration;

  /// No description provided for @initValues.
  ///
  /// In en, this message translates to:
  /// **'Init-values'**
  String get initValues;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @uploadFile.
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get uploadFile;

  /// No description provided for @fetch.
  ///
  /// In en, this message translates to:
  /// **'Fetch'**
  String get fetch;

  /// No description provided for @selectThumbnailProduct.
  ///
  /// In en, this message translates to:
  /// **'Select Thumbnail Product'**
  String get selectThumbnailProduct;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter Text'**
  String get enterText;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @smartUrl.
  ///
  /// In en, this message translates to:
  /// **'Smart URL'**
  String get smartUrl;

  /// No description provided for @templatePreview.
  ///
  /// In en, this message translates to:
  /// **'Template Preview'**
  String get templatePreview;

  /// No description provided for @pleaseSelectATemplateFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a template first'**
  String get pleaseSelectATemplateFirst;

  /// No description provided for @selectWaba.
  ///
  /// In en, this message translates to:
  /// **'Select WABA'**
  String get selectWaba;

  /// No description provided for @chooseGroup.
  ///
  /// In en, this message translates to:
  /// **'Choose group'**
  String get chooseGroup;

  /// No description provided for @editImage.
  ///
  /// In en, this message translates to:
  /// **'Edit Image'**
  String get editImage;

  /// No description provided for @showProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Show Profile Image'**
  String get showProfileImage;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout ?'**
  String get logoutContent;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @enterValidUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL'**
  String get enterValidUrl;

  /// No description provided for @youAreOffline.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get youAreOffline;

  /// No description provided for @youAreOnline.
  ///
  /// In en, this message translates to:
  /// **'You are online'**
  String get youAreOnline;

  /// No description provided for @doYouWantToGoOnline.
  ///
  /// In en, this message translates to:
  /// **'Do you want to go Online ?'**
  String get doYouWantToGoOnline;

  /// No description provided for @doYouWantToGoOffline.
  ///
  /// In en, this message translates to:
  /// **'Do you want to go Offline ?'**
  String get doYouWantToGoOffline;

  /// No description provided for @selectReason.
  ///
  /// In en, this message translates to:
  /// **'Select Reason'**
  String get selectReason;

  /// No description provided for @statusUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Status updated successfully.'**
  String get statusUpdatedSuccessfully;

  /// No description provided for @failedToUpdateStatus.
  ///
  /// In en, this message translates to:
  /// **'Failed to update status.'**
  String get failedToUpdateStatus;

  /// No description provided for @filterTags.
  ///
  /// In en, this message translates to:
  /// **'Filter Tags'**
  String get filterTags;

  /// No description provided for @noTagsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Tags Available'**
  String get noTagsAvailable;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @noTokensAssigned.
  ///
  /// In en, this message translates to:
  /// **'No Tokens are assigned right now'**
  String get noTokensAssigned;

  /// No description provided for @mobileNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile No'**
  String get mobileNoLabel;

  /// No description provided for @closedAgent.
  ///
  /// In en, this message translates to:
  /// **'Closed Agent'**
  String get closedAgent;

  /// No description provided for @masterAdmin.
  ///
  /// In en, this message translates to:
  /// **'Master Admin'**
  String get masterAdmin;

  /// No description provided for @noAgentsDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Agents Data Found'**
  String get noAgentsDataFound;

  /// No description provided for @forceLogoutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout the {agentName} session ?'**
  String forceLogoutQuestion(String agentName);

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @noAdsFound.
  ///
  /// In en, this message translates to:
  /// **'No Ads Information Found'**
  String get noAdsFound;

  /// No description provided for @noAdsInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'There is no ad information for this session'**
  String get noAdsInfoDesc;

  /// No description provided for @adHeadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Ad Headline'**
  String get adHeadlineLabel;

  /// No description provided for @adUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Ad URL'**
  String get adUrlLabel;

  /// No description provided for @adBodyLabel.
  ///
  /// In en, this message translates to:
  /// **'Ad Body'**
  String get adBodyLabel;

  /// No description provided for @viewInChat.
  ///
  /// In en, this message translates to:
  /// **'View in Chat'**
  String get viewInChat;

  /// No description provided for @adVideo.
  ///
  /// In en, this message translates to:
  /// **'Ad Video'**
  String get adVideo;

  /// No description provided for @adImage.
  ///
  /// In en, this message translates to:
  /// **'Ad Image'**
  String get adImage;

  /// No description provided for @adInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Ad Information'**
  String get adInformationTitle;

  /// No description provided for @numberOfVisits.
  ///
  /// In en, this message translates to:
  /// **'No. of visits'**
  String get numberOfVisits;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @unsubscribe.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribe;

  /// No description provided for @dnd.
  ///
  /// In en, this message translates to:
  /// **'DND'**
  String get dnd;

  /// No description provided for @nonDnd.
  ///
  /// In en, this message translates to:
  /// **'Non DND'**
  String get nonDnd;

  /// No description provided for @transferNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Transfer Note'**
  String get transferNoteLabel;

  /// No description provided for @transferNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Due to bulk assign tickets'**
  String get transferNoteHint;

  /// No description provided for @acceptableCount.
  ///
  /// In en, this message translates to:
  /// **'Acceptable Count'**
  String get acceptableCount;

  /// No description provided for @activeSessions.
  ///
  /// In en, this message translates to:
  /// **'ActiveSessions'**
  String get activeSessions;

  /// No description provided for @languagesKnown.
  ///
  /// In en, this message translates to:
  /// **'Languages Known'**
  String get languagesKnown;

  /// No description provided for @groupCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'GroupCode'**
  String get groupCodeLabel;

  /// No description provided for @noChatHistoryFound.
  ///
  /// In en, this message translates to:
  /// **'No Chat History Found'**
  String get noChatHistoryFound;

  /// No description provided for @noChatHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'There is no previous chat history for this session'**
  String get noChatHistoryDesc;

  /// No description provided for @actionTransferTicket.
  ///
  /// In en, this message translates to:
  /// **'Transfer Ticket'**
  String get actionTransferTicket;

  /// No description provided for @actionAdsInfo.
  ///
  /// In en, this message translates to:
  /// **'Ads Info'**
  String get actionAdsInfo;

  /// No description provided for @actionContactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get actionContactDetails;

  /// No description provided for @actionChatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get actionChatHistory;

  /// No description provided for @actionCloseTicket.
  ///
  /// In en, this message translates to:
  /// **'Close Ticket'**
  String get actionCloseTicket;

  /// No description provided for @actionReinitiateTicket.
  ///
  /// In en, this message translates to:
  /// **'Reinitiate Ticket'**
  String get actionReinitiateTicket;

  /// No description provided for @actionReopenTicket.
  ///
  /// In en, this message translates to:
  /// **'Reopen Ticket'**
  String get actionReopenTicket;

  /// No description provided for @historyTicketNo.
  ///
  /// In en, this message translates to:
  /// **'Ticket number'**
  String get historyTicketNo;

  /// No description provided for @historyAnsweredBy.
  ///
  /// In en, this message translates to:
  /// **'Answered by'**
  String get historyAnsweredBy;

  /// No description provided for @historyStart.
  ///
  /// In en, this message translates to:
  /// **'Start Date & Time'**
  String get historyStart;

  /// No description provided for @historyEnd.
  ///
  /// In en, this message translates to:
  /// **'End Date & Time'**
  String get historyEnd;

  /// No description provided for @historyTag.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get historyTag;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @contactDetailsName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactDetailsName;

  /// No description provided for @contactDetailsMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get contactDetailsMobileNumber;

  /// No description provided for @contactDetailsTransferBy.
  ///
  /// In en, this message translates to:
  /// **'Transfer by'**
  String get contactDetailsTransferBy;

  /// No description provided for @contactDetailsNoOfVisits.
  ///
  /// In en, this message translates to:
  /// **'No of visits'**
  String get contactDetailsNoOfVisits;

  /// No description provided for @contactDetailsLastTag.
  ///
  /// In en, this message translates to:
  /// **'Last Tag'**
  String get contactDetailsLastTag;

  /// No description provided for @contactDetailsLastComment.
  ///
  /// In en, this message translates to:
  /// **'Last Comment'**
  String get contactDetailsLastComment;

  /// No description provided for @ticketDetails.
  ///
  /// In en, this message translates to:
  /// **'Ticket Details'**
  String get ticketDetails;

  /// No description provided for @ticketDetailsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get ticketDetailsDisplay;

  /// No description provided for @ticketDetailsWaitTime.
  ///
  /// In en, this message translates to:
  /// **'Total wait time'**
  String get ticketDetailsWaitTime;

  /// No description provided for @ticketDetailsStartDate.
  ///
  /// In en, this message translates to:
  /// **'Chat Start Date & Time'**
  String get ticketDetailsStartDate;

  /// No description provided for @ticketDetailsEndDate.
  ///
  /// In en, this message translates to:
  /// **'Chat End Date & Time'**
  String get ticketDetailsEndDate;

  /// No description provided for @ticketDetailsPreviousAgent.
  ///
  /// In en, this message translates to:
  /// **'Previous conversation Agent'**
  String get ticketDetailsPreviousAgent;

  /// No description provided for @directoryDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Directory Details'**
  String get directoryDetailsTitle;

  /// No description provided for @transferSelectAgentType.
  ///
  /// In en, this message translates to:
  /// **'Select Type of Agent'**
  String get transferSelectAgentType;

  /// No description provided for @transferTicket.
  ///
  /// In en, this message translates to:
  /// **'Transfer Ticket'**
  String get transferTicket;

  /// No description provided for @transferSelectAgent.
  ///
  /// In en, this message translates to:
  /// **'Select Agent'**
  String get transferSelectAgent;

  /// No description provided for @transferNote.
  ///
  /// In en, this message translates to:
  /// **'Transfer Note'**
  String get transferNote;

  /// No description provided for @transferNoRolesFound.
  ///
  /// In en, this message translates to:
  /// **'No roles found'**
  String get transferNoRolesFound;

  /// No description provided for @transferSelectCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Please select category'**
  String get transferSelectCategoryHint;

  /// No description provided for @transferSelectAgentHint.
  ///
  /// In en, this message translates to:
  /// **'Please select {agentType}'**
  String transferSelectAgentHint(String agentType);

  /// No description provided for @transferNoOptions.
  ///
  /// In en, this message translates to:
  /// **'No options'**
  String get transferNoOptions;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @npsScore.
  ///
  /// In en, this message translates to:
  /// **'NPS Score'**
  String get npsScore;

  /// No description provided for @lastTwoMonths.
  ///
  /// In en, this message translates to:
  /// **'Last two months'**
  String get lastTwoMonths;

  /// No description provided for @noTicketsAreResolved.
  ///
  /// In en, this message translates to:
  /// **'No tickets are resolved'**
  String get noTicketsAreResolved;

  /// No description provided for @pageLiveAgentAgentInfoForLast24Hours.
  ///
  /// In en, this message translates to:
  /// **'Agent Info For Last 24 Hours'**
  String get pageLiveAgentAgentInfoForLast24Hours;

  /// No description provided for @pageLiveAgentOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get pageLiveAgentOnline;

  /// No description provided for @pageLiveAgentLoginButOffline.
  ///
  /// In en, this message translates to:
  /// **'Login but offline'**
  String get pageLiveAgentLoginButOffline;

  /// No description provided for @pageLiveAgentLoggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged Out'**
  String get pageLiveAgentLoggedOut;

  /// No description provided for @pageLiveAgentAverageQueueTime.
  ///
  /// In en, this message translates to:
  /// **'Average Queue Time'**
  String get pageLiveAgentAverageQueueTime;

  /// No description provided for @pageLiveAgentMaxQueueTime.
  ///
  /// In en, this message translates to:
  /// **'Max Queue Time'**
  String get pageLiveAgentMaxQueueTime;

  /// No description provided for @pageLiveAgentTotalChatsIgnored.
  ///
  /// In en, this message translates to:
  /// **'Total Chats Ignored'**
  String get pageLiveAgentTotalChatsIgnored;

  /// No description provided for @pageLiveAgentOfflineReason.
  ///
  /// In en, this message translates to:
  /// **'Offline Reason'**
  String get pageLiveAgentOfflineReason;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @logoutNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Logout Not Allowed'**
  String get logoutNotAllowed;

  /// No description provided for @assignedTicketsResolveWarning.
  ///
  /// In en, this message translates to:
  /// **'You have assigned tickets. Please resolve them before logging out.'**
  String get assignedTicketsResolveWarning;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @ticketAcceptedBy.
  ///
  /// In en, this message translates to:
  /// **'Ticket accepted by'**
  String get ticketAcceptedBy;

  /// No description provided for @noDirectoryDetails.
  ///
  /// In en, this message translates to:
  /// **'No directory details available'**
  String get noDirectoryDetails;

  /// No description provided for @closeTicketQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close this ticket?'**
  String get closeTicketQuestion;

  /// No description provided for @remarksLabel.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarksLabel;

  /// No description provided for @remarksHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter your remarks'**
  String get remarksHint;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @enterAtLeastTwoChars.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 2 characters'**
  String get enterAtLeastTwoChars;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select {roleName}'**
  String selectRole(String roleName);

  /// No description provided for @closeTicket.
  ///
  /// In en, this message translates to:
  /// **'Close Ticket'**
  String get closeTicket;

  /// No description provided for @lastComment.
  ///
  /// In en, this message translates to:
  /// **'Last Comment'**
  String get lastComment;

  /// No description provided for @noResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for {query}'**
  String noResultsFor(String query);

  /// No description provided for @chooseWabaAccount.
  ///
  /// In en, this message translates to:
  /// **'Choose WABA Account'**
  String get chooseWabaAccount;

  /// No description provided for @pleaseSelectWabaAccount.
  ///
  /// In en, this message translates to:
  /// **'Please select a WABA account'**
  String get pleaseSelectWabaAccount;

  /// No description provided for @chooseSenderPhone.
  ///
  /// In en, this message translates to:
  /// **'Choose Sender Phone'**
  String get chooseSenderPhone;

  /// No description provided for @pleaseSelectSenderPhone.
  ///
  /// In en, this message translates to:
  /// **'Please select a sender phone'**
  String get pleaseSelectSenderPhone;

  /// No description provided for @recipients.
  ///
  /// In en, this message translates to:
  /// **'Recipients'**
  String get recipients;

  /// No description provided for @enterRecipientPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter recipient phone number'**
  String get enterRecipientPhoneNumber;

  /// No description provided for @pleaseEnterRecipient.
  ///
  /// In en, this message translates to:
  /// **'Please enter a recipient'**
  String get pleaseEnterRecipient;

  /// No description provided for @template.
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get template;

  /// No description provided for @pleaseSelectTemplate.
  ///
  /// In en, this message translates to:
  /// **'Please select a template'**
  String get pleaseSelectTemplate;

  /// No description provided for @campaignCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Campaign created successfully'**
  String get campaignCreatedSuccessfully;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Fill all the fields'**
  String get fillAllFields;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL (must start with http or https)'**
  String get invalidUrl;

  /// No description provided for @selectVariable.
  ///
  /// In en, this message translates to:
  /// **'Select Variable'**
  String get selectVariable;

  /// No description provided for @headerAttributes.
  ///
  /// In en, this message translates to:
  /// **'Header Attributes'**
  String get headerAttributes;

  /// No description provided for @noFileSelected.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// No description provided for @mediaTypeNote.
  ///
  /// In en, this message translates to:
  /// **'Note : Template selected media type {type}, it accepts upto {size}.'**
  String mediaTypeNote(Object size, Object type);

  /// No description provided for @latitudeRequired.
  ///
  /// In en, this message translates to:
  /// **'Latitude is required'**
  String get latitudeRequired;

  /// No description provided for @longitudeRequired.
  ///
  /// In en, this message translates to:
  /// **'Longitude is required'**
  String get longitudeRequired;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @addressRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressRequired;

  /// No description provided for @invalidLatitude.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid latitude'**
  String get invalidLatitude;

  /// No description provided for @invalidLongitude.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid longitude'**
  String get invalidLongitude;

  /// No description provided for @errorLoadingCatalogue.
  ///
  /// In en, this message translates to:
  /// **'Error loading catalogue'**
  String get errorLoadingCatalogue;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @pleaseSelectThumbnailProduct.
  ///
  /// In en, this message translates to:
  /// **'Please select a thumbnail product'**
  String get pleaseSelectThumbnailProduct;

  /// No description provided for @shortUrlNote.
  ///
  /// In en, this message translates to:
  /// **'Note:During template creation, the URL is configured as a ShortURL.If you want to send parameters, you can use either:The URL, or The short link generated code'**
  String get shortUrlNote;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @selectAtLeastOneProduct.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one product'**
  String get selectAtLeastOneProduct;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @removeCategory.
  ///
  /// In en, this message translates to:
  /// **'Remove category'**
  String get removeCategory;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @selectProduct.
  ///
  /// In en, this message translates to:
  /// **'Select Product'**
  String get selectProduct;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'product Name'**
  String get productName;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed'**
  String get downloadFailed;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading…'**
  String get downloading;

  /// No description provided for @offerEnded.
  ///
  /// In en, this message translates to:
  /// **'Offer ended'**
  String get offerEnded;

  /// No description provided for @endsTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Ends today at {time}'**
  String endsTodayAt(Object time);

  /// No description provided for @endsIn1Day.
  ///
  /// In en, this message translates to:
  /// **'Ends in 1 day'**
  String get endsIn1Day;

  /// No description provided for @endsInDays.
  ///
  /// In en, this message translates to:
  /// **'Ends in {days} days'**
  String endsInDays(Object days);

  /// No description provided for @endsOnDate.
  ///
  /// In en, this message translates to:
  /// **'Ends on {date}'**
  String endsOnDate(Object date);

  /// No description provided for @seeAllOptions.
  ///
  /// In en, this message translates to:
  /// **'See all options'**
  String get seeAllOptions;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card {index}'**
  String card(int index);

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @ticketTransfer.
  ///
  /// In en, this message translates to:
  /// **'Ticket Transfer'**
  String get ticketTransfer;

  /// No description provided for @transferFailed.
  ///
  /// In en, this message translates to:
  /// **'Transfer Failed'**
  String get transferFailed;

  /// No description provided for @ticketTransferredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Ticket Transferred Successfully'**
  String get ticketTransferredSuccessfully;

  /// No description provided for @ticketDoesNotExists.
  ///
  /// In en, this message translates to:
  /// **'Ticket does not exists'**
  String get ticketDoesNotExists;

  /// No description provided for @noDirectoryDetailsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No directory details available'**
  String get noDirectoryDetailsAvailable;

  /// No description provided for @enterAtLeastFiveCharacters.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 5 characters'**
  String get enterAtLeastFiveCharacters;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred: {error}'**
  String unexpectedError(String error);

  /// No description provided for @subscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribed;

  /// No description provided for @unsubscribed.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribed;

  /// No description provided for @ticketDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get ticketDisplayName;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError('AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
