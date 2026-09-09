# 📰 مصر الآن | Egypt Now News App

تطبيق موبايل إخباري متكامل ومتعدد المنصات مبني باستخدام إطار عمل **Flutter** ولغة **Dart**، لتقديم أحدث الأخبار المحلية والعالمية لحظة بلحظة وبواجهة مستخدم عصرية باللغة العربية.

---

## فكرة التطبيق وأهدافه؟
* **نبذة عن التطبيق؟** تطبيق إخباري شامل بيعرض آخر الأخبار الحية في مختلف المجالات (تكنولوجيا، رياضة، اقتصاد، سياسة، مصر والعالم) مع نظام تسجيل دخول وحسابات شخصية وتحديث مستمر للأخبار.
* **الهدف الأساسي؟** توفير منصة إخبارية ذكية، سريعة، وسلسة للمستخدم العربي لمتابعة الأحداث أول بأول بدقة عالية وبواجهة متجاوبة مع جميع الشاشات.

---

## التقنيات والأدوات المستخدمة (Tech Stack)
* **Framework:** Flutter (Dart)
* **Backend & Database:** Firebase (Authentication, Cloud Firestore)
* **APIs:** GNews API & NewsAPI.org
* **Fonts:** Google Fonts (Cairo & Poppins)

---

## البنية التحتية والاعتماد على فايربيز ولماذا استخدمت Firebase؟
تم الاعتماد على **Firebase** للأسباب التالية:
1. **الأمان والموثوقية:** لتوفير نظام مصادقة قوي (Authentication) يدعم تسجيل الدخول بالبريد الإلكتروني وكلمة المرور مع التحقق من البريد.
2. **تسجيل الدخول السريع:** لتسهيل عملية الدخول للمستخدمين عبر حساب Google بضغطة زر واحدة.
3. **المرونة والسرعة:** لسرعة ربط التطبيق بقاعدة البيانات وإدارة حالة المستخدمين (State Management للأمان) بسهولة تامة.

---

## جلب البيانات والربط مع الواجهات البرمجية
* **المصدر:** 
تم جلب الأخبار من خلال خدمات عالمية موثوقة ومخصصة للمطورين وهي **GNews API** و **NewsAPI.org**.
* **الطريقة:**
 يتم إرسال طلبات HTTP (HTTP Requests) ديناميكية بناءً على التصنيف المختار من المستخدم (سياسة، رياضة، تكنولوجيا...)، ومعالجة البيانات وعرضها داخل التطبيق بشكل لحظي باستخدام `FutureBuilder`.

---

##  أهم الـ Features الموجودة
* **شاشة ترحيبية (Splash Screen):** واجهة بداية جذابة مع التحقق التلقائي من حالة تسجيل دخول المستخدم.
* **نظام مصادقة شامل (Authentication):** 
  * تسجيل الدخول وإنشاء حساب جديد عبر البريد الإلكتروني مع التحقق من تفعيل الحساب.
  * إمكانية تسجيل الدخول السريع باستخدام حساب Google.
  * ميزة استعادة كلمة المرور عبر البريد الإلكتروني.
* **تصنيفات متعددة للأخبار:** تصفح الأخبار مقسمة بمرونة (الكل، تكنولوجيا، رياضة، اقتصاد، سياسة، مصر).
* **شريط الأخبار العاجلة (Trending & Slider):** عرض أهم الأخبار البارزة بتصميم متحرك وتلقائي (Auto-scroll).
* **صفحة تفاصيل الخبر:** عرض محتوى الخبر كاملاً مع الصورة، المصدر، والنص التوضيحي.
* **إدارة الحساب والإعدادات (Profile & Settings):** لوحة تحكم مصغرة للمستخدم مع إمكانية تسجيل الخروج وعرض معلومات التطبيق والتراخيص.
* **التوافقية التامة (Responsive UI):** أداة مخصصة لضبط المقاسات والأبعاد (`Responsive`) لضمان ظهور التطبيق بشكل مثالي على كافة الأجهزة.

---

## صور من التطبيق (App Screenshots)

<p align="center">
  <img width="299" height="649" alt="Image" src="https://github.com/user-attachments/assets/0d446b06-3dfc-4e5d-8125-fa874a2396a6" />
  <img width="297" height="649" alt="Image" src="https://github.com/user-attachments/assets/856185c0-6c02-4149-86eb-611220efd8a6" />
  <img width="299" height="647" alt="Image" src="https://github.com/user-attachments/assets/c73be857-f937-4750-a087-4a34deffd5fb" />
  <img width="492" height="1073" alt="Image" src="https://github.com/user-attachments/assets/44f094fd-b48f-494a-8130-43552eac678f" />
  <img width="301" height="649" alt="Image" src="https://github.com/user-attachments/assets/02170d8e-79d7-4d60-8b69-3417716cdf1e" />
  <img width="297" height="645" alt="Image" src="https://github.com/user-attachments/assets/7972add6-ccb4-41ab-9763-78020c095aed" />
  <img width="300" height="648" alt="Image" src="https://github.com/user-attachments/assets/d91bc97d-b274-4929-96fd-13747558b826" />
  <img width="301" height="650" alt="Image" src="https://github.com/user-attachments/assets/a04225bc-e90b-4854-a2bc-cf3516a3f279" />
  <img width="298" height="646" alt="Image" src="https://github.com/user-attachments/assets/25eab5d4-6dc1-4983-bf7d-2d628fed0a08" />
</p>

---

## شكل وتنظيم المشروع (Project Structure)
```text
lib/
│
├── auth/          # شاشات تسجيل الدخول، إنشاء الحساب، والتحقق
├── data/          # ملفات جلب البيانات والاتصال بالـ APIs الخارجية
├── model/         # نماذج بيانات الأخبار وأداة التجاوب (Responsive & Models)
├── page/          # الشاشات الرئيسية (الرئيسية، تفاصيل الخبر، كل الأخبار، الـ Splash)
├── widget/        # المكونات والعناصر المتكررة (Categories, Trend, Last News, Custom Inputs)
├── firebase_options.dart # إعدادات منصات فايربيز المختلفة
└── main.dart      # نقطة انطلاق التطبيق وفحص حالة المصادقة