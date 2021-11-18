import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Properties
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  
  var detailViewController: DetailViewController? = nil
  var Words = [Word]()
  var filteredWords = [Word]()
  let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Word"
    searchController.hidesNavigationBarDuringPresentation = false
    navigationItem.titleView = searchController.searchBar
    definesPresentationContext = true
    
    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
    searchController.searchBar.delegate = self
    
    // Setup the search footer
    tableView.tableFooterView = searchFooter
    
    Words = [ //A
        Word(category:"Meaning: Having the power", name:"Able", detail: "Synonyms: Intelligent, Clever, Brilliant, Talented, Skilful, Skilled, Gifted, Expert"),
        Word(category:"Meaning: Existing or Available in large quantities", name:"Abundant", detail: "Synonyms: Plentiful, Copious, Ample, Profuse, Rich, Lavish, Liberal, Large, Huge, Great"),
        Word(category:"Meaning: Increase in rate", name:"Accelerate", detail: "Synonyms: Speed up, Hurry up, Get Faster, Open it up, Put on a spurt, Gather Speed"),
        Word(category:"Meaning: Make more noticeable or Prominent", name:"Accentuate", detail: "Synonyms: Underline, Underscore, Accent, Highlight, Spotlight, Feature"),
        Word(category:"Meaning: The means or opportunity to approach", name:"Access", detail: "Synonyms: Entrance, Entry, Way in, Ingress, Means of entry"),
        Word(category:"Meaning: Able to be reached or entered", name:"Accessible", detail: "Synonyms: Reachable, Attainable, Approachable, Within reach, Available, On hand, Abtainable"),
        Word(category:"Meaning: Praise enthusiastically and publicly", name:"Acclaim", detail: "Synonyms: praise, applaud, cheer, commend, express approval of, approve, express admiration for, welcome"),
        Word(category:"Meaning: An award or privilege granted as a special honour", name:"Accolade", detail: "Synonyms: honour, recognition, privilege, award, gift, title"),
        Word(category:"Meaning: Achieve or complete successfully", name:"Accomplish", detail: "Synonyms: fulfil, achieve, succeed in, realize, attain, manage, bring about, bring off, carry out"),
        Word(category:"Meaning: Something that has been achieved successfully", name:"Accomplishment", detail: "Synonyms: achievement, act, deed, exercise, exploit, performance, attainment, effort, feat"),
        Word(category:"Meaning: The fact or condition of being accountable", name:"Accountability", detail: "Synonyms: responsibility, liability, answerability"),
        Word(category:"Meaning: Give credit to (someone) for something", name:"Accredited", detail: "Synonyms: recognize as, credit with, empower, depute, endorse"),
        Word(category:"Meaning: Correct in all details", name:"Accurate", detail: "Synonyms: correct, precise, exact, right, errorless, error-free, without error, faultless, perfect"),
        Word(category:"Meaning: Successfully bring about or reach", name:"Achieve", detail: "Synonyms: attain, reach, arrive at"),
        Word(category:"Meaning: Engaging or ready to engage in physically energetic pursuits", name:"Active", detail: "Synonyms: mobile, energetic, agile, sporty, nimble, vigorous, vital, dynamic"),
        Word(category:"Meaning: A person who campaigns to bring about political or social change", name:"Activist", detail: "Synonyms: advocate, opponent, revolutionary"),
        Word(category:"Meaning: Make (something) suitable for a new use or purpose", name:"Adapt", detail: "Synonyms: modify, alter, make alterations to, change, adjust, make adjustments to, convert"),
        Word(category:"Meaning: Alter or move (something) slightly in order to achieve the desired fit, appearance, or result", name:"Adjust", detail: "Synonyms: modify, alter, regulate, tune, fine-tune, calibrate, balance"),
        Word(category:"Meaning: Regard with respect or warm approval", name:"Admire", detail: "Synonyms: applaud, praise, express admiration for, commend, approve of, express approval for"),
        Word(category:"Meaning: Move forwards in a purposeful way", name:"Advance", detail: "Synonyms: move forward, proceed, move along, press on, push on, push forward, make progress"),
        Word(category:"Meaning: A condition or circumstance that puts one in a favourable or superior position", name:"Advantage", detail: "Synonyms: upper hand, edge, lead, head, whip hand, trump card"),
        Word(category:"Meaning: An unusual and exciting or daring experience", name:"Adventure", detail: "Synonyms: exploit, escapade, deed, feat, trial, experience, incident, occurrence, event"),
        Word(category:"Meaning: Guidance or recommendations offered with regard to prudent action", name:"Advice", detail: "Synonyms: guidance, advising, counselling, counsel, help, direction, instruction, information, enlightenment"),
        Word(category:"Meaning: A person who publicly supports or recommends a particular cause or policy", name:"Advocate", detail: "Synonyms: champion, upholder, supporter, backer, promoter, proponent, exponent, protector"),
        Word(category:"Meaning: A natural liking for and understanding of someone or something", name:"Affinity", detail: "Synonyms: empathy, rapport, sympathy, accord, harmony, like-mindedness"),
        Word(category:"Meaning: State emphatically or publicly", name:"Affirm", detail: "Synonyms: declare, state, assert, aver, proclaim, pronounce, attest, swear, avow, vow"),
        Word(category:"Meaning: A list of items to be discussed at a formal meeting", name:"Agenda", detail: "Synonyms: list of items, schedule, programme, timetable, line-up, list, listing, to-do list, plan"),
        Word(category:"Meaning: Have the same opinion about something; concur", name:"Agree", detail: "Synonyms: concur, be of the same mind/opinion, see eye to eye, be in sympathy, sympathize"),
        Word(category:"Meaning: Point or direct (a weapon or camera) at a target", name:"Aim", detail: "Synonyms: point, direct, train, sight, focus, level, line up, position"),
        Word(category:"Meaning: Living, Not dead", name:"Alive", detail: "Synonyms: living, live, having life, not dead"),
        Word(category:"Meaning: Change in character or composition, typically in a comparatively small but significant way", name:"Alter", detail: "Synonyms: change, make changes to, make different, make alterations to, adjust"),
        Word(category:"Meaning: Available as another possibility or choice", name:"Alternative", detail: "Synonyms: different, other, another, second, possible, substitute, replacement"),
        Word(category:"Meaning: Surprise (someone) greatly", name:"Amaze", detail: "Synonyms: astonish, astound, surprise, bewilder, stun, stagger, flabbergast, nonplus, shock, startle"),
        Word(category:"Meaning: A strong desire to do or achieve something", name:"Ambition", detail: "Synonyms: aspiration, intention, goal, aim, objective, object, purpose, intent, plan, scheme, mission"),
        Word(category:"Meaning: Open and responsive to suggestion; easily persuaded or controlled", name:"Amenable", detail: "Synonyms: compliant, acquiescent, biddable, manageable, controllable, governable, persuadable"),
        Word(category:"Meaning: Make minor changes to (a text, piece of legislation, etc.) in order to make it fairer or more accurate, or to reflect changing circumstances", name:"Amend", detail: "Synonyms: revise, alter, change, modify, qualify, adapt, adjust"),
        Word(category:"Meaning: A desirable or useful feature or facility of a building or place", name:"Amenity", detail: "Synonyms: facility, service, convenience, resource, utility, system, appliance, aid, advantage"),
        Word(category:"Meaning: A comparison between one thing and another, typically for the purpose of explanation or clarification", name:"Analogy", detail: "Synonyms: similarity, parallel, parallelism, correspondence, likeness, resemblance, correlation"),
        Word(category:"Meaning: Examine (something) methodically and in detail, typically in order to explain and interpret it", name:"Analyse", detail: "Synonyms: examine, inspect, survey, scan, study, scrutinize, look over, peruse"),
        Word(category:"Meaning: Full of life or excitement; lively", name:"Animated", detail: "Synonyms: lively, spirited, high-spirited, energetic, full of life, excited, enthusiastic, eager, alive"),
        Word(category:"Meaning: Make a formal public statement about a fact, occurrence, or intention", name:"Announce", detail: "Synonyms: make public, make known, report, issue a statement about, declare, state, set forth, give out"),
        Word(category:"Meaning: Regard as probable; expect or predict", name:"Anticipate", detail: "Synonyms: expect, foresee, predict, think likely, forecast, prophesy, foretell, contemplate the possibility of"),
        Word(category:"Meaning: Clearly visible or understood; obvious", name:"Apparent", detail: "Synonyms: evident, plain, obvious, clear, manifest, visible, discernible, perceptible, perceivable"),
        Word(category:"Meaning: Make a serious, urgent, or heartfelt request", name:"Appeal", detail: "Synonyms: ask urgently/earnestly, request urgently/earnestly, make an urgent/earnest request, call"),
        Word(category:"Meaning: Show approval or praise by clapping", name:"Applaud", detail: "Synonyms: clap, cheer, whistle, give a standing ovation to, put one's hands together"),
        Word(category:"Meaning: Relevant or appropriate", name:"Applicable", detail: "Synonyms: relevant, appropriate, pertinent, apposite, germane, material, felicitous, significant"),
        Word(category:"Meaning: (of a subject of study) Put to practical use as opposed to being theoretical", name:"Applied", detail: "Synonyms: put in an application, put in, try, bid, appeal, petition, make an entreaty, sue, register"),
        Word(category:"Meaning: Make a formal application or request", name:"Apply", detail: "Synonyms: put in an application, put in, try, bid, appeal, petition, make an entreaty, sue, register"),
        Word(category:"Meaning: Assign a job or role to (someone)", name:"Appoint", detail: "Synonyms: nominate, name, designate, install as, commission, engage, adopt, co-opt"),
        Word(category:"Meaning: An act of assessing something or someone", name:"Appraisal", detail: "Synonyms: assessment, evaluation, estimation, judgement, rating, gauging, sizing up, summing-up"),
        Word(category:"Meaning: Recognize the full worth of", name:"Appreciate", detail: "Synonyms: value, respect, prize, cherish, treasure, admire, hold in high regard, hold in esteem"),
        Word(category:"Meaning: Come near or nearer to (someone or something) in distance or time", name:"Approach", detail: "Synonyms: proceed towards, come/go towards, advance towards, go near/nearer, come near/nearer"),
        Word(category:"Meaning: Suitable or proper in the circumstances", name:"Appropriate", detail: "Synonyms: suitable, proper, fitting, apt"),
        Word(category:"Meaning: Officially agree to or accept as satisfactory", name:"Approve", detail: "Synonyms: accept, agree to, consent to, assent to, acquiesce in, concur in, accede to, give one's blessing to"),
        Word(category:"Meaning: Appropriate or suitable in the circumstances", name:"Apt", detail: "Synonyms: suitable, fitting, appropriate, befitting, relevant, felicitous, congruous, fit, applicable"),
        Word(category:"Meaning: A natural ability to do something", name:"Aptitude", detail: "Synonyms: talent, gift, flair, bent, skill, knack, facility, finesse, genius"),
        Word(category:"Meaning: (of an independent person or body) Reach an authoritative judgement or settlement", name:"Arbitrate", detail: "Synonyms: adjudicate, judge, adjudge, referee, umpire, sit in judgement, pass judgement"),
        Word(category:"Meaning: A very typical example of a certain person or thing", name:"Archetype", detail: "Synonyms: typification, type, prototype, representative, stereotype"),
        Word(category:"Meaning: Very enthusiastic or passionate", name:"Ardent", detail: "Synonyms: passionate, avid, impassioned, fervent, fervid, zealous, wholehearted, eager"),
        Word(category:"Meaning: A level area surrounded by seating, in which sports, entertainments, and other public events are held", name:"Arena", detail: "Synonyms: stadium, amphitheatre, theatre, coliseum"),
        Word(category:"Meaning: Give reasons or cite evidence in support of an idea, action, or theory, typically with the aim of persuading others to share one's view", name:"Argue", detail: "Synonyms: contend, assert, declare, maintain, state, proclaim, advance, insist, hold, claim, aver"),
        Word(category:"Meaning: A distinctive, typically pleasant smell", name:"Aroma", detail: "Synonyms: smell, odour, fragrance, scent, perfume, whiff, redolence, tang, savour, bouquet, nose"),
        Word(category:"Meaning: Put (things) in a neat, attractive, or required order", name:"Arrange", detail: "Synonyms: put in order, order, set out, lay out, spread out, array, present, put out, display"),
        Word(category:"Meaning: An impressive display or range of a particular type of thing", name:"Array", detail: "Synonyms: arrangement, assembling, assemblage, line-up, formation, ordering, disposition"),
        Word(category:"Meaning: Seize (someone) by legal authority and take them into custody", name:"Arrest", detail: "Synonyms: apprehend, take into custody, seize, take in, take prisoner, detain, put in jail"),
        Word(category:"Meaning: Having or showing the ability to speak fluently and coherently", name:"Articulate", detail: "Synonyms: eloquent, fluent, communicative, effective, persuasive, coherent, lucid, vivid"),
        Word(category:"Meaning: Having or revealing natural creative skill", name:"Artistic", detail: "Synonyms: creative, imaginative, inventive, original"),
        Word(category:"Meaning: Find (something) out for certain; make sure of: an attempt to ascertain the cause of the accident", name:"Ascertain", detail: "Synonyms: find out, discover, get/come to know, work out, make out, fathom (out), become aware of, learn"),
        Word(category:"Meaning: A particular part or feature of something", name:"Aspect", detail: "Synonyms: feature, facet, side, characteristic, particular, detail, point, ingredient, strand"),
        Word(category:"Meaning: Direct one's hopes or ambitions towards achieving something", name:"Aspire", detail: "Synonyms: desire (to), aim for/to, hope for/to, long for/to, yearn for/to, hanker after/for/to, set one's heart on"),
        Word(category:"Meaning: State a fact or belief confidently and forcefully", name:"Assert", detail: "Synonyms: declare, maintain, contend, argue, state, claim, propound, submit, posit, postulate"),
        Word(category:"Meaning: Having or showing a confident and forceful personality", name:"Assertive", detail: "Synonyms: confident, forceful, self-confident, positive, bold, decisive, assured, self-assured, self-possessed"),
        Word(category:"Meaning: Evaluate or estimate the nature, ability, or quality of", name:"Assess", detail: "Synonyms: evaluate, judge, gauge, rate, estimate, appraise, form an opinion of, check out, form an impression of"),
        Word(category:"Meaning: A useful or valuable thing or person", name:"Asset", detail: "Synonyms: benefit, advantage, blessing, good point, strong point, strength, forte, talent, gift, strong suit"),
        Word(category:"Meaning: Showing great care and perseverance", name:"Assiduous", detail: "Synonyms: diligent, careful, meticulous, thorough, sedulous, attentive, industrious, laborious, hard-working"),
        Word(category:"Meaning: Allocate (a job or duty)", name:"Assign", detail: "Synonyms: allocate, allot, give, set"),
        Word(category:"Meaning: Help (someone), typically by doing a share of the work", name:"Assist", detail: "Synonyms: help, aid, abet, lend a (helping) hand to, give assistance to, be of use to, oblige"),
        Word(category:"Meaning: Connect (someone or something) with something else in one's mind", name:"Associate", detail: "Synonyms: link, connect, couple, relate, identify, equate, bracket, think of together"),
        Word(category:"Meaning: Suppose to be the case, without proof", name:"Assume", detail: "Synonyms: presume, suppose, take it, take for granted, take as read, take it as given"),
        Word(category:"Meaning: Tell someone something positively to dispel any doubts", name:"Assure", detail: "Synonyms: reassure, convince, satisfy, persuade, guarantee, promise, tell"),
        Word(category:"Meaning: Surprise or impress (someone) greatly", name:"Astonish", detail: "Synonyms: amaze, astound, stagger, surprise, startle, stun, confound, dumbfound, stupefy, daze, nonplus"),
        Word(category:"Meaning: Shock or greatly surprise", name:"Astound", detail: "Synonyms: amaze, astonish, stagger, surprise, startle, stun, confound, dumbfound, stupefy, daze, nonplus"),
        Word(category:"Meaning: Having or showing an ability to accurately assess situations or people and turn this to one's advantage", name:"Astute", detail: "Synonyms: shrewd, sharp, sharp-witted, razor-sharp, acute, quick, quick-witted, ingenious, clever"),
        Word(category:"Meaning: The envelope of gases surrounding the earth or another planet", name:"Atmosphere", detail: "Synonyms: air, aerosphere, airspace, sky"),
        Word(category:"Meaning: Notice taken of someone or something; the regarding of someone or something as interesting or important", name:"Attention", detail: "Synonyms: awareness, notice, observation, consciousness, heed, recognition, regard, scrutiny"),
        Word(category:"Meaning: Cause to come to a place or participate in a venture by offering something of interest or advantage", name:"Attract", detail: "Synonyms: entice, allure, lure, tempt, charm, win over, woo, engage, enchant, entrance"),
        Word(category:"Meaning: Pleasing or appealing to the senses", name:"Attractive", detail: "Synonyms: good-looking, nice-looking, beautiful, pretty, as pretty as a picture, handsome, lovely, stunning"),
        Word(category:"Meaning: Showing a willingness to take surprisingly bold risks", name:"Audacious", detail: "Synonyms: bold, daring, fearless, intrepid, brave, unafraid, unflinching, courageous, valiant, valorous"),
        Word(category:"Meaning: An interview for a role or job as a singer, actor, dancer, or musician, consisting of a practical demonstration of the candidate's suitability and skill", name:"Audition", detail: "Synonyms: demo, tryout, audience, hearing, trial, try on"),
        Word(category:"Meaning: (of an event or circumstance) Portend a good or bad outcome", name:"Augur", detail: "Synonyms: bode, diviner, forecaster, harbinger, herald, oracle"),
        Word(category:"Meaning: The distinctive atmosphere or quality that seems to surround and be generated by a person", name:"Aura", detail: "Synonyms: atmosphere, air, quality, aspect, character, ambience, mood, spirit, feeling, feel"),
        Word(category:"Meaning: Conducive to success; favourable", name:"Auspicious", detail: "Synonyms: favourable, propitious, promising, full of promise, bright, rosy, good, optimistic, hopeful, encouraging"),
        Word(category:"Meaning: Severe or strict in manner or attitude", name:"Austere", detail: "Synonyms: severe, stern, strict, harsh, unfeeling, stony, steely, flinty, dour, grim, cold, frosty, frigid, icy"),
        Word(category:"Meaning: Of undisputed origin and not a copy", name:"Authentic", detail: "Synonyms: genuine, original, real, actual, pukka, bona fide, true, veritable"),
        Word(category:"Meaning: Able to be trusted as being accurate or true", name:"Authoritative", detail: "Synonyms: reliable, dependable, trustworthy, good, sound, authentic, valid, well founded"),
        Word(category:"Meaning: The power or right to give orders, make decisions, and enforce obedience", name:"Authority", detail: "Synonyms: power, jurisdiction, command, control, mastery, charge, dominance, dominion, rule"),
        Word(category:"Meaning: The action of authorizing", name:"Authorization", detail: "Synonyms: approval, authority, endorsement, green light, sanction, signature"),
        Word(category:"Meaning: Give official permission for or approval to (an undertaking or agent)", name:"Authorize", detail: "Synonyms: give permission for, permit, sanction, allow, agree to, approve, give one's consent/assent to"),
        Word(category:"Meaning: The right or condition of self-government", name:"Autonomy", detail: "Synonyms: self-government, independence, self-rule, home rule, sovereignty, self-determination, freedom"),
        Word(category:"Meaning: Able to be used or obtained; at someone's disposal", name:"Available", detail: "Synonyms: obtainable, accessible, to be had, ready for use, at hand, to hand, at one's disposal, at one's fingertips"),
        Word(category:"Meaning: Having or showing a keen interest in or enthusiasm for something", name:"Avid", detail: "Synonyms: keen, eager, enthusiastic, ardent, passionate, devoted, dedicated, fervent, fervid, zealous"),
        Word(category:"Meaning: Give or order the giving of (something) as an official payment, compensation, or prize to (someone)", name:"Award", detail: "Synonyms: give, grant"),
        Word(category:"Meaning: Having knowledge or perception of a situation or fact", name:"Aware", detail: "Synonyms: conscious of, acquainted with, informed of/about, apprised of, cognizant of, mindful of, sensible of"),
        Word(category:"Meaning: a feeling of reverential respect mixed with fear or wonder", name:"Awe", detail: "Synonyms: wonder, wonderment, amazement, astonishment"),
        Word(category:"Meaning: A statement or proposition which is regarded as being established, accepted, or self-evidently true", name:"Axiom", detail: "Synonyms: accepted truth, general truth, dictum, truism, principle"),
        
        //B
        
        
        Word(category:"Meaning: the rear surface of the human body from the shoulders to the hips", name:"Back", detail: "Synonyms: spine, backbone, spinal column, vertebral column"),
        Word(category:"Meaning: an even distribution of weight enabling someone or something to remain upright and steady", name:"Balance", detail: "Synonyms: stability, equilibrium, steadiness, footing"),
        Word(category:"Meaning: an agreement between two or more people or groups as to what each will do for the other", name:"Bargain", detail: "Synonyms: agreement, arrangement, understanding, deal"),
        Word(category:"Meaning: the lowest part or edge of something, especially the part on which it rests or is supported", name:"Base", detail: "Synonyms: foundation, bottom, foot, support, prop, stay, stand, pedestal, plinth, rest, bed, substructure"),
        Word(category:"Meaning: forming an essential foundation or starting point", name:"Basic", detail: "Synonyms: fundamental, rudimentary, primary, principal, cardinal, chief, elementary, elemental, root"),
        Word(category:"Meaning: the underlying support or foundation for an idea, argument, or process", name:"Basis", detail: "Synonyms: starting point, base, point of departure, beginning, premise"),
        Word(category:"Meaning: lie exposed to warmth and light, typically from the sun, for relaxation and pleasure", name:"Bask", detail: "Synonyms: laze, lie, lounge, relax, sprawl, loll"),
        Word(category:"Meaning: pleasing the senses or mind aesthetically", name:"Beautiful", detail: "Synonyms: attractive, pretty, handsome, good-looking, nice-looking, pleasing, alluring, prepossessing"),
        Word(category:"Meaning: a standard or point of reference against which things may be compared", name:"Benchmark", detail: "Synonyms: standard, point of reference, basis, gauge, criterion, specification, canon, convention, guide, guideline"),
        Word(category:"Meaning: resulting in good", name:"Beneficial", detail: "Synonyms: advantageous, favourable, helpful, useful, of use, of benefit, of assistance, serviceable, of service"),
        Word(category:"Meaning: an advantage or profit gained from something", name:"Benefit", detail: "Synonyms: good, sake, interest, welfare, well-being, satisfaction, enjoyment, advantage, comfort, ease, convenience"),
        Word(category:"Meaning: be evidence of; indicate", name:"Bespeak", detail: "Synonyms:  indicate, be an indication of, be evidence of, be a sign of, testify to, bear witness to, reflect"),
        Word(category:"Meaning: of the most excellent or desirable type or quality", name:"Best", detail: "Synonyms: finest, greatest, top, foremost, leading, pre-eminent, premier, prime, first, chief, principal, supreme"),
        Word(category:"Meaning: (especially of a house or flat) small and elegant", name:"Bijou", detail: "Synonyms: small, little, compact, snug, cosy"),
        Word(category:"Meaning: mix (a substance) with another substance so that they combine together", name:"Blend", detail: "Synonyms: mix, mingle, combine, put together, stir, whisk, fold in, jumble, merge"),
        Word(category:"Meaning: God's favour and protection", name:"Blessing", detail: "Synonyms: protection, favour"),
        Word(category:"Meaning: perfect happiness; great joy", name:"Bliss", detail: "Synonyms: joy, pleasure, delight, happiness, gladness, ecstasy, elation, rapture, euphoria, heaven, paradise"),
        Word(category:"Meaning: a flower, especially one cultivated for its beauty", name:"Bloom", detail: "Synonyms: flower, blossom, floweret"),
        Word(category:"Meaning: a flower or a mass of flowers, especially on a tree or bush", name:"Blossom", detail: "Synonyms: flower, blossom, floweret"),
        Word(category:"Meaning: a design plan or other technical drawing", name:"Blueprint", detail: "Synonyms: plan, design, draft, diagram, drawing, scale drawing, outline, sketch, pattern, map, layout, representation"),
        Word(category:"Meaning: talk with excessive pride and self-satisfaction about one's achievements, possessions, or abilities", name:"Boast", detail: "Synonyms: brag, crow, swagger, swank, gloat, show off, blow one's own trumpet, sing one's own praises"),
        Word(category:"Meaning: (of a person, action, or idea) showing a willingness to take risks; confident and courageous", name:"Bold", detail: "Synonyms: daring, intrepid, courageous, brave, valiant, fearless, unafraid, undaunted, dauntless, valorous"),
        Word(category:"Meaning: a long, thick pillow that is placed under other pillows for ", name:"Bolster", detail: "Synonyms: pillow, cushion, pad, support, rest"),
        Word(category:"Meaning: a sum of money added to a person's wages as a reward for good performance", name:"Bonus", detail: "Synonyms: extra payment, gratuity, tip, handout, gift, present, honorarium, reward, prize, commission, dividend"),
        Word(category:"Meaning: a loud, deep, resonant sound", name:"Boom", detail: "Synonyms: reverberation, resonance, resounding"),
        Word(category:"Meaning: help or encourage (something) to increase or improve", name:"Boost", detail: "Synonyms: improve, raise, uplift, increase, augment, magnify, swell, amplify, enhance, encourage, heighten"),
        Word(category:"Meaning: large in quantity; abundant", name:"Bountiful", detail: "Synonyms: abundant, plentiful, ample, bumper, superabundant, inexhaustible, prolific, profuse, teeming, copious"),
        Word(category:"Meaning: a small shop selling fashionable clothes or accessories", name:"Boutique", detail: "Synonyms: booth, store, concession, franchise"),
        Word(category:"Meaning: a type of product manufactured by a particular company under a particular name", name:"Brand", detail: "Synonyms: make, line, label, marque"),
        Word(category:"Meaning: ready to face and endure danger or pain; showing courage", name:"Brave", detail: "Synonyms: courageous, plucky, fearless, valiant, valorous, intrepid, heroic, lionhearted, manful, macho, bold, daring, daredevil"),
        Word(category:"Meaning: astonishing or awe-inspiring in quality, so as to take one's breath away", name:"Breathtaking", detail: "Synonyms: spectacular, magnificent, wonderful, awe-inspiring, awesome, astounding, astonishing, amazing, stunning, stupendous"),
        Word(category:"Meaning: of short duration; not lasting for long", name:"Brief", detail: "Synonyms: short, flying, fleeting, hasty, hurried, quick, cursory, perfunctory"),
        Word(category:"Meaning: giving out or reflecting much light; shining", name:"Bright", detail: "Synonyms: shining, light, brilliant, vivid, blazing, dazzling, beaming, intense, glaring"),
        Word(category:"Meaning: (of light or colour) very bright", name:"Brilliant", detail: "Synonyms: bright, shining, blazing, dazzling, light"),
        Word(category:"Meaning: become larger in distance from side to side; widen", name:"Broaden", detail: "Synonyms: widen, become/make broader, become/make wider, expand, fill out, stretch (out), draw out, spread out, deepen, thicken"),
        Word(category:"Meaning: (of a plant) having or developing buds", name:"Budding", detail: "Synonyms: promising, up-and-coming, rising, coming, in the making, aspiring, future, prospective, with potential"),
        Word(category:"Meaning: an estimate of income and expenditure for a set period of time", name:"Budget", detail: "Synonyms: financial plan, financial estimate, financial blueprint, prediction of revenue and expenditure, forecast"),
        Word(category:"Meaning: a person or thing that reduces a shock or that forms a barrier between incompatible or antagonistic people or things", name:"Buffer", detail: "Synonyms: cushion, bulwark"),
        Word(category:"Meaning: construct (something) by putting parts or material together", name:"Build", detail: "Synonyms: construct, erect, put up, assemble, set up, raise"),
        Word(category:"Meaning: aggressively confident and self-assertive", name:"Bullish", detail: "Synonyms: optimistic, hopeful, buoyant, positive, disposed to look on the bright side, sanguine, confident, cheerful, cheery, bright, assured, animated, spirited"),
        Word(category:"Meaning: able or tending to keep afloat or rise to the top of a liquid or gas", name:"Buoyant", detail: "Synonyms: able to float, light, floating; rarefloatable"),
        Word(category:"Meaning: a person's regular occupation, profession, or trade", name:"Business", detail: "Synonyms: work, line of work, line, occupation, profession, career, employment, job, day job, position, pursuit, vocation, calling, field, sphere"),
        
        
        //C
        
        Word(category:"Meaning: determine (the amount or number of something) mathematically", name:"Calculate", detail: "Synonyms: compute, work out, reckon, figure, enumerate, determine, evaluate, quantify, assess, cost, put a figure on"),
        Word(category:"Meaning: the quality of someone's character or the level of their ability", name:"Calibre", detail: "Synonyms: quality, merit, distinction, character, worth, stature, excellence, superiority, eminence, pre-eminence"),
        Word(category:"Meaning: not showing or feeling nervousness, anger, or other strong emotions", name:"Calm", detail: "Synonyms: windless, still, tranquil, quiet, serene, peaceful, pacific, undisturbed, restful, balmy, halcyon"),
        Word(category:"Meaning: a series of military operations intended to achieve a goal, confined to a particular area, or involving a specified type of fighting", name:"Campaign", detail: "Synonyms: crusade, drive, push, effort, struggle, move, movement"),
        Word(category:"Meaning: truthful and straightforward; frank", name:"Candid", detail: "Synonyms: frank, outspoken, forthright, blunt, open, honest, truthful, sincere, direct, straightforward, plain-spoken, bluff, unreserved"),
        Word(category:"Meaning: (capable of doing something) having the ability, fitness, or quality necessary to do or achieve a specified thing", name:"Capable", detail: "Synonyms: have the ability to, have the potential to, be equal to (the task of), be up to"),
        Word(category:"Meaning: the maximum amount that something can contain", name:"Capacity", detail: "Synonyms: volume, cubic measure"),
        Word(category:"Meaning: attract and hold the interest and attention of; charm", name:"Captivate", detail:"Synonyms:enthral,charm,enchant, bewitch, fascinate, beguile, entrance, enrapture, delight, attract, allure, lure"),
        Word(category:"Meaning: the provision of what is necessary for the health, welfare, maintenance, and protection of someone or something", name:"Care", detail: "Synonyms: safe keeping, supervision, custody, charge, protection, keeping, keep, control, management, ministration, guidance"),
        Word(category:"Meaning: making sure of avoiding potential danger, mishap, or harm; cautious", name:"Careful", detail: "Synonyms: cautious, heedful, alert, aware, attentive, watchful, vigilant, wary, on guard, chary, circumspect, prudent, mindful, guarded"),
        Word(category:"Meaning: a small waterfall, typically one of several that fall in stages down a steep rocky slope", name:"Cascade", detail: "Synonyms: waterfall, falls, water chute, cataract, rapids, torrent, flood, deluge, outpouring, white water, fountain, shower, avalanche"),
        Word(category:"Meaning: a substance that increases the rate of a chemical reaction without itself undergoing any permanent chemical change", name:"Catalyst", detail: "Synonyms: Equivalent, Metonym"),
        Word(category:"Meaning: unambiguously explicit and direct", name:"Categorical", detail: "Synonyms: unqualified, unconditional, unequivocal, unreserved, absolute, explicit, unambiguous, definite, certain, direct, downright, outright"),
            Word(category:"Meaning: provide with what is needed or required", name:"Cater", detail: "Synonyms: provide food for, feed, serve, cook for, wine and dine, regale, provide for, provision; datedvictual"),
            Word(category:"Meaning: a person or thing that gives rise to an action, phenomenon, or condition", name:"Cause", detail: "Synonyms: source, root, origin, beginning(s), starting point, seed, germ, genesis, agency, occasion"),
            Word(category:"Meaning: acknowledge (a significant or happy day or event) with a social gathering or enjoyable activity", name:"Celebrate", detail: "Synonyms: commemorate, observe, honour, mark, salute, recognize, acknowledge, remember, memorialize, keep, drink to, toast"),
            Word(category:"Meaning: at the point or in the area that is in the middle of something", name:"Central", detail: "Synonyms: middle, centre, halfway, midway, mid, median, medial, mean, middling, intermediate, intermedial"),
            Word(category:"Meaning: the point that is equally distant from every point on the circumference of a circle or sphere", name:"Centre", detail: "Synonyms: middle, nucleus, heart, core, hub, pivot, kernel, eye, bosom"),
            Word(category:"Meaning: able to be firmly relied on to happen or be the case", name:"Certain", detail: "Synonyms: unquestionable, sure, definite, beyond question, not in question, not in doubt, beyond doubt, unequivocal, indubitable"),
            Word(category:"Meaning: attest or confirm in a formal statement", name:"Certify", detail: "Synonyms: verify, guarantee, attest, validate, ratify, warrant, confirm, corroborate, substantiate, endorse, vouch for, testify to, provide evidence of"),
            Word(category:"Meaning: a call to someone to participate in a competitive situation or fight to decide who is superior in terms of ability or strength", name:"Challenge", detail:"Synonyms: Dare, Provocation, Summons"),
            Word(category:"Meaning: a person who has surpassed all rivals in a sporting contest or other competition", name:"Champion", detail: "Synonyms: winner, title-holder, defending champion, gold medallist"),
            Word(category:"Meaning: the mental and moral qualities distinctive to an individual", name:"Character", detail: "Synonyms: personality, nature, disposition, temperament, temper, mentality, turn of mind, psychology, psyche, constitution, make-up"),
            Word(category:"Meaning: compelling attractiveness or charm that can inspire devotion in others", name:"Charisma", detail: "Synonyms: charm, presence, aura, personality, force of personality, strength of character, individuality"),
            Word(category:"Meaning: the power or quality of delighting, attracting, or fascinating others", name:"Charm", detail: "Synonyms: attractiveness, beauty, glamour, prettiness, loveliness"),
            Word(category:"Meaning: noticeably happy and optimistic", name:"Cheerful", detail: "Synonyms: happy, jolly, merry, bright, glad, sunny, joyful, joyous, light-hearted, in good spirits, in high spirits, sparkling, bubbly, exuberant, ebullient"),
            Word(category:"Meaning: protect and care for (someone) lovingly", name:"Cherish", detail: "Synonyms: adore, hold dear, love, care very much for, feel great affection for, dote on, be devoted to, revere, esteem, admire, appreciate"),
            Word(category:"Meaning: a leader or ruler of a people or clan", name:"Chief", detail: "Synonyms: leader, chieftain, head, headman, ruler, overlord, master, commander, suzerain, seigneur, liege, liege lord, potentate"),
            Word(category:"Meaning: an act of choosing between two or more possibilities", name:"Choice", detail: "Synonyms: option, alternative, possibility, possible course of action"),
            Word(category:"Meaning: pick out (someone or something) as being the best or most appropriate of two or more alternatives", name:"Choose", detail: "Synonyms: select, pick, pick out, opt for, plump for, go for, take, settle on, decide on, fix on, come down in favour of, vote for"),
            Word(category:"Meaning: a factual written account of important or historical events in the order of their occurrence", name:"Chronicle", detail: "Synonyms: record, written account, history, annals, archive(s), register"),
            Word(category:"Meaning: a fact or condition connected with or relevant to an event or action", name:"Circumstance", detail: "Synonyms: situation, conditions, set of conditions, state of affairs, things, position"),
            Word(category:"Meaning: relating to ordinary citizens and their concerns, as distinct from military or ecclesiastical matters", name:"Civil", detail: "Synonyms: secular, non-religious, lay"),
            Word(category:"Meaning: state or assert that something is the case, typically without providing evidence or proof", name:"Claim", detail: "Synonyms: assert, declare, profess, maintain, state, hold, affirm, avow, aver, protest, insist, swear, attest"),
            Word(category:"Meaning: make (a statement or situation) less confused and more comprehensible", name:"Clarify", detail: "Synonyms: make clear, shed light on, throw light on, elucidate, illuminate, make plain, make simple, simplify"),
            Word(category:"Meaning: a set or category of things having some property or attribute in common and differentiated from others by kind, type, or quality", name:"Class", detail: "Synonyms: category, grade, rating, classification, group, grouping, bracket, set"),
            Word(category:"Meaning: judged over a period of time to be of the highest quality and outstanding of its kind", name:"Classic", detail: "Synonyms: Definitive, Authoritative"),
            Word(category:"Meaning: arrange (a group of people or things) in classes or categories according to shared qualities or characteristics", name:"Classify", detail: "Synonyms: categorize, class, group, put into sets, grade, rank, rate, order, organize, range, sort, type, codify, bracket"),
            Word(category:"Meaning: free from dirt, marks, or stains", name:"Clean", detail: "Synonyms: washed, scrubbed, cleansed, cleaned, polished"),
            Word(category:"Meaning: easy to perceive, understand, or interpret", name:"Clear", detail: "Synonyms: understandable, comprehensible, intelligible, easy to understand, plain, direct, uncomplicated, explicit, lucid"),
            Word(category:"Meaning: quick to understand, learn, and devise or apply ideas; intelligent", name:"Clever", detail: "Synonyms: intelligent, bright, smart, brilliant"),
            Word(category:"Meaning: only a short distance away or apart in space or time", name:"Close", detail: "Synonyms: near, adjacent, in close proximity, close/near at hand"),
            Word(category:"Meaning: an act or process of closing something, especially an institution, thoroughfare, or frontier, or of being closed", name:"Closure", detail: "Synonyms: closing down, shutting down, shutdown, winding up"),
            Word(category:"Meaning: a comfortably equipped single-decker bus used for longer journeys", name:"Coach", detail: "Synonyms: BUs, minibus, van, carriage, wagon, pullman"),
            Word(category:"Meaning: persuade (someone) gradually or gently to do something", name:"Coax", detail: "Synonyms: persuade, wheedle, cajole, talk into something, get round, prevail on, beguile, flatter, seduce, lure, entice, tempt, inveigle, woo"),
            Word(category:"Meaning: an alcoholic drink consisting of a spirit or spirits mixed with other ingredients, such as fruit juice or cream", name:"Cocktail", detail:"Synonyms: aperitif, drink, appetiser, wine"),
            Word(category:"Meaning: a system of words, letters, figures, or symbols used to represent others, especially for the purposes of secrecy", name:"Code", detail: "Synonyms: cipher, secret language, secret writing, set of symbols, key, hieroglyphics"),
            Word(category:"Meaning: (of an argument or case) clear, logical, and convincing", name:"Cogent", detail: "Synonyms: convincing, compelling, strong, forceful, powerful, potent, weighty"),
            Word(category:"Meaning: (of an argument, theory, or policy) logical and consistent", name:"Coherent", detail: "Synonyms:logical, reasoned, reasonable, well reasoned, rational, sound, cogent"),
            Word(category:"Meaning: comprising six centuries, equal to one tenth of a legion", name:"Cohort", detail: "Synonyms: Unit, outfit, force, group, grade"),
            Word(category:"Meaning: work jointly on an activity or project", name:"Collaborate", detail: "Synonyms: cooperate, join (up), join forces, team up, get together, come together, band together, work together, work jointly, participate"),
            Word(category:"Meaning: a person with whom one works in a profession or business", name:"Colleague", detail: "Synonyms: fellow worker, workmate, teammate, co-worker, associate, partner, co-partner, collaborator, ally, comrade, companion, confederate"),
            Word(category:"Meaning: having much or varied colour; bright", name:"Colourful", detail: "Synonyms: brightly coloured, bright-coloured, deep-coloured, brilliant, glowing, radiant, vivid, rich, vibrant"),
            Word(category:"Meaning: join or merge to form a single unit or substance", name:"Combine", detail: "Synonyms: amalgamate, merge, unite, integrate, incorporate, fuse, blend, meld, mingle, coalesce, compound, alloy, homogenize"),
            Word(category:"Meaning: a state of physical ease and freedom from pain or constraint", name:"Comfort", detail: "Synonyms: ease, freedom from hardship, repose, relaxation, serenity, tranquillity, contentment, content, well-being"),
            Word(category:"Meaning: give an authoritative or peremptory order", name:"Command", detail: "Synonyms: order, give orders to, give the order to, tell, direct, instruct, call on, enjoin, adjure, charge, require, prescribe; literarybid"),
            Word(category:"Meaning: recall and show respect for (someone or something)", name:"Commemorate", detail: "Synonyms: celebrate, pay tribute to, pay homage to, honour, salute, toast"),
            Word(category:"Meaning: praise formally or officially", name:"Commend", detail: "Synonyms: praise, compliment, congratulate, applaud, clap, cheer, toast, salute, admire, honour, glorify, extol, eulogize, sing the praises of"),
            Word(category:"Meaning: corresponding in size or degree; in proportion", name:"Commensurate", detail: "Synonyms: equivalent, equal, corresponding, correspondent, comparable, proportionate, proportional"),
            Word(category:"Meaning: a verbal or written remark expressing an opinion or reaction", name:"Comment", detail: "Synonyms: remark, observation, statement, utterance, pronouncement, judgement, reflection, opinion, view, criticism"),
            Word(category:"Meaning: an expression of opinions or offering of explanations about an event or situation", name:"Commentary", detail: "Synonyms: narration, description, account, report, review, analysis"),
            Word(category:"Meaning: the activity of buying and selling, especially on a large scale", name:"Commerce", detail: "Synonyms: trade, trading, buying and selling, business, bargaining, dealing, traffic, trafficking"),
            Word(category:"Meaning: an instruction, command, or role given to a person or group", name:"Commission", detail: "Synonyms: task, employment, job, work, piece of work, project, mission, assignment, undertaking, exercise, enterprise, endeavour"),
            Word(category:"Meaning: perpetrate or carry out (a mistake, crime, or immoral act)", name:"Commit", detail: "Synonyms: carry out, do, perform, perpetrate, engage in, enact, execute, effect, accomplish"),
            Word(category:"Meaning: the state or quality of being dedicated to a cause, activity, etc.", name:"Commitment", detail: "Synonyms: dedication, devotion, allegiance, loyalty, faithfulness, fidelity, bond, adherence, attentiveness"),
            Word(category:"Meaning: hare or exchange information, news, or ideas", name:"Communicate", detail: "Synonyms:liaise, be in touch, be in contact, be in communication, make contact, have dealings, interface, commune, meet, meet up"),
            Word(category:"Meaning: a group of people living in the same place or having a particular characteristic in common", name:"Community", detail: "Synonyms: group, section, body, company, set, circle, clique, coterie, ring, band, faction"),
            Word(category:"Meaning: closely and neatly packed together; dense", name:"Compact", detail: "Synonyms: dense, packed close, close-packed, tightly packed, pressed together"),
            Word(category:"Meaning: estimate, measure, or note the similarity or dissimilarity between", name:"Compare", detail: "Synonyms: contrast, set side by side, juxtapose, collate, differentiate, weigh up, balance"),
            Word(category:"Meaning: (of two things) able to exist or occur together without problems or conflict", name:"Compatible", detail: "Synonyms: well suited, suited, well matched, like-minded, of the same mind, in agreement, in tune, in harmony, reconcilable"),
            Word(category:"Meaning: evoking interest, attention, or admiration in a powerfully irresistible way", name:"Compelling", detail: "Synonyms: enthralling, captivating, gripping, engrossing, riveting, spellbinding, entrancing, transfixing, mesmerizing, hypnotic, mesmeric"),
            Word(category:"Meaning: having the necessary ability, knowledge, or skill to do something successfully", name:"Competent", detail: "Synonyms: capable, able, proficient, adept, adroit, accomplished, skilful, skilled, gifted, talented, masterly, virtuoso, expert, knowledgeable, qualified"),
            Word(category:"Meaning: relating to or characterized by competition", name:"Competitive", detail: "Synonyms: ruthless, merciless, aggressive, fierce"),
            Word(category:"Meaning: a thing that contributes extra features to something else in such a way as to improve or emphasize its quality", name:"Complement", detail: "Synonyms: accompaniment, companion, addition, supplement, accessory, adjunct, trimming, finishing touch, final touch"),
            Word(category:"Meaning: consisting of many different and connected parts", name:"Complex", detail: "Synonyms: compound, composite, compounded, multiplex"),
            Word(category:"Meaning: a polite expression of praise or admiration", name:"Compliment", detail: "Synonyms: flattering remark, tribute, accolade, commendation, bouquet, pat on the back, encomium"),
            Word(category:"Meaning: including or dealing with all or nearly all elements or aspects of something", name:"Comprehensive", detail:"Synonyms: inclusive, all-inclusive, complete"),
            Word(category:"Meaning: giving a lot of information clearly and in a few words; brief but comprehensive", name:"Concise", detail: "Synonyms: succinct, short, brief, to the point, pithy, incisive, short and sweet, crisp"),
            Word(category:"Meaning: bring or come to an end", name:"Conclude", detail: "Synonyms: finish, end, come to an end, draw to a close, wind up, be over, stop, terminate, close, cease"),
            Word(category:"Meaning: naturally accompanying or associated", name:"Concomitant", detail: "Synonyms: attendant, accompanying, associated, collateral, related, connected, linked"),
            Word(category:"Meaning: the state of something with regard to its appearance, quality, or working order", name:"Condition", detail: "Synonyms: state, shape, order; informalnick"),
            Word(category:"Meaning: making a certain situation or outcome likely or possible", name:"Conducive", detail: "Synonyms: good for, helpful to, instrumental in, calculated to produce, productive of, useful for"),
            Word(category:"Meaning: showing confidence in oneself or one's abilities or qualities", name:"Confident", detail: "Synonyms: self-assured, assured, sure of oneself, self-confident, positive"),
            Word(category:"Meaning: establish the truth or correctness of (something previously believed or suspected to be the case)", name:"Confirm", detail: "Synonyms: affirm, reaffirm, assert, reassert, give an assurance, assure someone, repeat, say again, state again, pledge, promise, guarantee"),
            Word(category:"Meaning: give (someone) one's good wishes when something special or pleasant has happened to them", name:"Congratulate", detail: "Synonyms: give someone one's good wishes, wish someone good luck, wish someone joy, drink someone's health, toast"),
            Word(category:"Meaning: bring together or into contact so that a real or notional link is established", name:"Connect", detail: "Synonyms: attach, join, fasten, fix, affix, couple, link, bridge, secure, make fast, tie, tie up, bind, fetter, strap, rope, tether, truss, lash, hitch, moor"),
            Word(category:"Meaning: an idea or feeling which a word invokes for a person in addition to its literal or primary meaning", name:"Connotation", detail: "Synonyms: overtone, undertone, undercurrent, implication, hidden meaning, secondary meaning, nuance, flavour, feeling, aura, atmosphere, colouring"),
            Word(category:"Meaning: wishing to do one's work or duty well and thoroughly", name:"Conscientious", detail: "Synonyms: diligent, industrious, punctilious, painstaking, sedulous, assiduous, dedicated, careful, meticulous, thorough, attentive, laborious"),
            Word(category:"Meaning: a general agreement", name:"Consensus", detail: "Synonyms: agreement, harmony, concord, like-mindedness, concurrence, consent, common consent, accord, unison, unity, unanimity"),
            Word(category:"Meaning: permission for something to happen or agreement to do something", name:"Consent", detail: "Synonyms: agreement, assent, concurrence, accord"),
            Word(category:"Meaning: a result or effect, typically one that is unwelcome or unpleasant", name:"Consequence", detail: "Synonyms: result, upshot, outcome, out-turn, sequel, effect, reaction, repercussion, reverberations, ramification, end, end result"),
            Word(category:"Meaning: think carefully about (something), typically before making a decision", name:"Consider", detail: "Synonyms: think about, contemplate, give thought to, reflect on, examine, appraise, review"),
            Word(category:"Meaning: acting or done in the same way over time, especially so as to be fair or accurate", name:"Consistent", detail: "Synonyms: steady, stable, constant, regular, even, uniform, orderly, unchanging, unvarying, unswerving, undeviating, unwavering"),
            Word(category:"Meaning: make (something) physically stronger or more solid", name:"Consolidate", detail: "Synonyms: strengthen, make stronger, make secure, secure, make stable, stabilize, reinforce, fortify, tighten, harden, stiffen, cement, enhance"),
            Word(category:"Meaning: clearly visible", name:"Conspicuous", detail: "Synonyms: easily seen, clear, visible, clearly visible, standing out, noticeable, observable, discernible, perceptible, perceivable"),
            Word(category:"Meaning: having or intended to have a useful or beneficial purpose", name:"Constructive", detail: "Synonyms: positive, useful, of use, helpful, encouraging"),
            Word(category:"Meaning: seek information or advice from (someone, especially an expert or professional)", name:"Consult", detail: "Synonyms: ask, seek advice/information from, take counsel from, call on/upon/in, turn to, have recourse to"),
            Word(category:"Meaning: a person who provides expert advice professionally", name:"Consultant", detail:"Synonyms: adviser, guide, counsellor"),
            Word(category:"Meaning: make (a marriage or relationship) complete by having sexual intercourse", name:"Consummate", detail: "Synonyms: complete, conclude, finish, accomplish, achieve"),
            Word(category:"Meaning: living or occurring at the same time", name:"Contemporary", detail: "Synonyms: contemporaneous, concurrent, coeval, synchronous, synchronic, of the time, of the day, simultaneous"),
            Word(category:"Meaning: an outline representing or bounding the shape or form of something", name:"Contour", detail:"Synonyms: outline, shape, form"),
            Word(category:"Meaning: the state of being strikingly different from something else in juxtaposition or close association", name:"Contrast", detail: "Synonyms: difference, dissimilarity, disparity, dissimilitude, distinction, contradistinction, divergence, variance, variation, differentiation"),
            Word(category:"Meaning: cause (someone) to believe firmly in the truth of something", name:"Convince", detail: "Synonyms: persuade, satisfy, prove to, cause to feel certain"),
            Word(category:"Meaning: involving mutual assistance in working towards a common goal", name:"Cooperative", detail: "Synonyms: collaborative, collective, communal, combined, common, joint, shared, mutual, united, unified, allied, cross-party, pooled"),
            Word(category:"Meaning: bring the different elements of (a complex activity or organization) into a harmonious or efficient relationship", name:"Coordinate", detail: "Synonyms: harmonize, correlate, interrelate, synchronize, bring together"),
            Word(category:"Meaning: the tough central part of various fruits, containing the seeds", name:"Core", detail: "Synonyms: central, key, basic, fundamental, elemental, principal, primary, main, chief, crucial, vital, essential"),
            Word(category:"Meaning: have a mutual relationship or connection, in which one thing affects or depends on another", name:"Correlate", detail: "Synonyms: correspond, agree, tally, match up, tie in, be consistent, be in agreement, be compatible, be consonant, be congruous"),
            Word(category:"Meaning: confirm or give support to (a statement, theory, or finding)", name:"Corroborate", detail: "Synonyms: confirm, verify, endorse, ratify, authenticate, validate, certify"),
            Word(category:"Meaning: including people from many different countries", name:"Cosmopolitan", detail: "Synonyms: worldly, worldly-wise, well travelled, knowing, aware, mature, seasoned, experienced, unprovincial, cultivated, cultured"),
            Word(category:"Meaning: giving a feeling of comfort, warmth, and relaxation", name:"Cosy", detail: "Synonyms: snug, comfortable, warm, restful, homelike, homey, homely, cheerful, welcoming, pleasant, agreeable"),
            Word(category:"Meaning: the ability to do something that frightens one; bravery", name:"Courage", detail: "Synonyms: bravery, braveness, courageousness, pluck, pluckiness, valour, fearlessness, intrepidity, intrepidness, nerve, daring"),
            Word(category:"Meaning: relating to or involving the use of the imagination or original ideas to create something", name:"Creative", detail:"Synonyms: inventive, imaginative, innovative, innovatory, innovational, experimental, original"),
            Word(category:"Meaning: a qualification, achievement, quality, or aspect of a person's background, especially when used to indicate their suitability for something", name:"Credential", detail:"Synonyms: Testimonial, voucher, sanction, passport, docket, endorsement, missive"),
            Word(category:"Meaning: able to be believed; convincing", name:"Credible", detail: "Synonyms: acceptable, trustworthy, reliable, dependable, sure, good, valid"),
            Word(category:"Meaning: (of a performance, effort, or action) deserving public acknowledgement and praise but not necessarily outstanding or successful", name:"Creditable", detail: "Synonyms: commendable, praiseworthy, laudable, admirable, honourable, estimable, meritorious, exceptional, exemplary, noteworthy, notable, worthy"),
            Word(category:"Meaning: a principle or standard by which something may be judged or decided", name:"Criterion", detail: "Synonyms: basis, point of reference, standard, norm, yardstick, benchmark, touchstone, test, formula, measure, gauge, scale, barometer, indicator"),
            Word(category:"Meaning: expressing adverse or disapproving comments or judgements", name:"Critical", detail: "Synonyms: censorious, condemnatory, condemning, castigatory, reproving, denunciatory, deprecatory, disparaging, disapproving, scathing"),
            Word(category:"Meaning: a detailed analysis and assessment of something, especially a literary, philosophical, or political theory", name:"Critique", detail: "Synonyms: analysis, evaluation, assessment, appraisal, appreciation, review, write-up"),
            Word(category:"Meaning: decisive or critical, especially in the success or failure of something", name:"Crucial", detail: "Synonyms: pivotal, critical, key, climacteric, decisive, deciding, determining, settling, testing, trying, searching"),
            Word(category:"Meaning: the decisive or most important point at issue", name:"Crux", detail: "Synonyms: nub, heart, essence, most important point, central point, main point, essential part, core, centre, nucleus, kernel"),
            Word(category:"Meaning: the arts and other manifestations of human intellectual achievement regarded collectively", name:"Culture", detail: "Synonyms: the arts, the humanities"),
            Word(category:"Meaning: a traditional and widely accepted way of behaving or doing something that is specific to a particular society, place, or time", name:"Custom", detail: "Synonyms: tradition, practice, usage, observance, way, convention, procedure, ceremony, ritual, ordinance, form, formality, fashion, mode"),
    
             //D
    
    
        Word(category:"Meaning: (of a person or action) adventurous or audaciously bold", name:"Daring", detail: "Synonyms: bold, audacious, adventurous, intrepid, venturesome, fearless, brave, unafraid, unshrinking, undaunted, dauntless, valiant"),
        Word(category:"Meaning: a formal discussion on a particular matter in a public meeting or legislative assembly", name:"Debate", detail:"Synonyms: discussion, exchange of views, discourse, parley"),
        Word(category:"Meaning: settling an issue; producing a definite result", name:"Decisive", detail:"Synonyms: deciding, conclusive, determining, final, settling, key"),
        Word(category:"Meaning: say something in a solemn and emphatic manner", name:"Declare", detail: "Synonyms: proclaim, announce, make known, state, communicate, reveal, divulge, mention, talk about, raise, moot, air, bring into the open"),
        Word(category:"Meaning: devote (time or effort) to a particular task or purpose", name:"Dedicate", detail: "Synonyms: devote, commit, pledge, bind, obligate, give, give over, surrender, set aside, allot, allocate, consign, sacrifice"),
        Word(category:"Meaning: (of a conclusion or agreement) done or reached decisively and with authority", name:"Definitive", detail: "Synonyms: conclusive, final, ultimate"),
        Word(category:"Meaning: a person sent or authorized to represent others, in particular an elected representative sent to a conference", name:"Delegate", detail: "Synonyms: representative, envoy, emissary, commissioner, agent, deputy, commissary"),
        Word(category:"Meaning: done consciously and intentionally", name:"Deliberate", detail: "Synonyms: intentional, calculated, conscious, done on purpose, intended, planned, meant, considered, studied, knowing, wilful, wanton"),
        Word(category:"Meaning: very fine in texture or structure; of intricate workmanship or quality", name:"Delicate", detail: "Synonyms: fine, exquisite, intricate, dainty, airy, elegant, graceful"),
        Word(category:"Meaning: please (someone) greatly", name:"Delight", detail: "Synonyms: please greatly, charm, enchant, captivate, entrance, bewitch, thrill, excite, take someone's breath away"),
        Word(category:"Meaning: bring and hand over (a letter, parcel, or goods) to the proper recipient or address", name:"Deliver", detail: "Synonyms: bring, take, take round, convey, carry, transport, distribute, drop-ship"),
        Word(category:"Meaning: trustworthy and reliable", name:"Dependable", detail: "Synonyms: reliable, trustworthy, honourable, true, faithful, loyal, constant, unswerving, unwavering, unfailing, sure, steadfast, steady, stable"),
        Word(category:"Meaning: serving or seeking to describe", name:"Descriptive", detail: "Synonyms: illustrative, expressive, pictorial, depictive, graphic, picturesque, vivid, striking"),
        Word(category:"Meaning: worthy of being treated in a particular way, typically of being given assistance", name:"Deserving", detail: "Synonyms: worthy, meritorious, commendable, praiseworthy, laudable, excellent, fine, admirable, estimable, exemplary, creditable"),
        Word(category:"Meaning: a plan or drawing produced to show the look and function or workings of a building, garment, or other object before it is made", name:"Design", detail: "Synonyms: plan, blueprint, drawing, scale drawing, sketch, outline, map, plot, diagram, delineation, draft, depiction, representation"),
        Word(category:"Meaning: an individual fact or item", name:"Detail", detail: "Synonyms: particular, feature, characteristic, respect, ingredient, attribute, item, specific, fact, piece of information, point, factor"),
        Word(category:"Meaning: having made a firm decision and being resolved not to change it", name:"Determined", detail: "Synonyms: intent on, bent on, set on, dead set on, insistent on, fixed on, resolved on/to, firm about, committed to, hell-bent on"),
        Word(category:"Meaning: grow or cause to grow and become more mature, advanced, or elaborate", name:"Develop", detail: "Synonyms: grow, evolve, mature, expand, enlarge, spread, advance, progress, prosper, succeed, thrive"),
        Word(category:"Meaning: give all or most of one's time or resources to (a person or activity)", name:"Devote", detail: "Synonyms: allocate, assign, allot, commit, give, give over, afford, apportion, surrender, consign, sacrifice, pledge, dedicate, consecrate"),
        Word(category:"Meaning: a conversation between two or more people as a feature of a book, play, or film", name:"Dialogue", detail: "Synonyms: conversation, talk, communication, interchange, discourse, argument"),
        Word(category:"Meaning: the state or quality of being worthy of honour or respect", name:"Dignity", detail: "Synonyms: high rank, high standing, high station, status, elevation, eminence, honour, glory, greatness, importance, prominence, prestige"),
        Word(category:"Meaning: having or showing care and conscientiousness in one's work or duties", name:"Diligent", detail: "Synonyms: industrious, hard-working, assiduous"),
        Word(category:"Meaning: a measurable extent of a particular kind, such as length, breadth, depth, or height", name:"Dimension", detail: "Synonyms: proportions, measurements, extent, size"),
        Word(category:"Meaning: of or concerning diplomacy", name:"Diplomatic", detail: "Synonyms: ambassadorial, consular, foreign-policy, political"),
        Word(category:"Meaning: recognize or find out", name:"Discern", detail: "Synonyms: perceive, make out, pick out, detect, recognize, notice, observe, see, spot"),
        Word(category:"Meaning: find unexpectedly or during a search", name:"Discover", detail: "Synonyms: find, locate, come across, come upon, stumble on, chance on, light on, bring to light, uncover, unearth, turn up, track down"),
        Word(category:"Meaning: talk about (something) with a person or people", name:"Discuss", detail: "Synonyms: talk over, talk about, talk through, converse about, debate, confer about, put your heads together about, deliberate about, chew over"),
        Word(category:"Meaning: put (something) in a prominent place in order that it may readily be seen", name:"Display", detail: "Synonyms: exhibit, show, put on show, put on view, expose to view, present, unveil, set forth"),
        Word(category:"Meaning: recognizably different in nature from something else of a similar type", name:"Distinct", detail: "Synonyms: clear, clear-cut, definite, well defined, sharp, marked, decided, unmistakable, easily distinguishable"),
        Word(category:"Meaning: characteristic of one person or thing, and so serving to distinguish it from others", name:"Distinctive", detail: "Synonyms: distinguishing, characteristic, typical, individual, particular, peculiar, idiosyncratic, differentiating, unique, exclusive, special, especial"),
        Word(category:"Meaning: recognize or treat (someone or something) as different", name:"Distinguish", detail: "Synonyms: differentiate, tell apart, discriminate, discern, determine, pick out"),
        Word(category:"Meaning: showing a great deal of variety; very different", name:"Diverse", detail: "Synonyms: various, many and various, sundry, manifold, multiple"),
        Word(category:"Meaning: a piece of written, printed, or electronic matter that provides information or evidence or that serves as an official record", name:"Document", detail: "Synonyms: official paper, legal paper, paper, form, certificate, deed, charter, contract, legal agreement"),
        Word(category:"Meaning: (of an event or circumstance) sudden and striking", name:"Dramatic", detail: "Synonyms: considerable, substantial, sizeable, goodly, fair, reasonable, tidy, marked, pronounced"),
        Word(category:"Meaning: operate and control the direction and speed of a motor vehicle", name:"Drive", detail: "Synonyms: operate, pilot, steer, handle, manage"),
        Word(category:"Meaning: (of a person) positive in attitude and full of energy and new ideas", name:"Dynamic", detail: "Synonyms: energetic, spirited, active, lively, zestful, vital, vigorous, strong, forceful, powerful, potent, positive, effective, effectual"),
    
    
        //E
        
        Word(category:"Meaning: relating to economics or the economy", name:"Economic", detail: "Synonyms: financial, monetary, pecuniary, budgetary, fiscal, commercial, trade, mercantile"),
        Word(category:"Meaning: successful in producing a desired or intended result", name:"Effective", detail: "Synonyms: successful, effectual, efficacious, productive, constructive, fruitful, functional, potent, powerful"),
        Word(category:"Meaning: (of a system or machine) achieving maximum productivity with minimum wasted effort or expense", name:"Efficient", detail: "Synonyms: well organized, methodical, systematic, structured, well planned, logical, coherent, well regulated, well run, well ordered, orderly, businesslike"),
        Word(category:"Meaning: graceful and stylish in appearance or manner", name:"Elegant", detail: "Synonyms: stylish, graceful, tasteful, discerning, refined, sophisticated, dignified, cultivated, distinguished, classic, smart, fashionable"),
        Word(category:"Meaning: fluent or persuasive in speaking or writing", name:"Eloquent", detail: "Synonyms: persuasive, expressive, articulate, fluent"),
        Word(category:"Meaning: be an expression of or give a tangible or visible form to (an idea, quality, or feeling)", name:"Embody", detail: "Synonyms: personify, incorporate, give human form/shape to, realize, manifest, express, concretize, symbolize, represent, epitomize"),
        Word(category:"Meaning: move out of or away from something and become visible", name:"Emerge", detail: "Synonyms: come out, appear, come into view, become visible, make an appearance"),
        Word(category:"Meaning: (of a person) famous and respected within a particular sphere", name:"Eminent", detail: "Synonyms: illustrious, distinguished, renowned, esteemed, pre-eminent, notable, noteworthy, great, prestigious, important, significant, influential"),
        Word(category:"Meaning: special importance, value, or prominence given to something", name:"Emphasis", detail: "Synonyms: prominence, importance, significance"),
        Word(category:"Meaning: give (someone) the authority or power to do something", name:"Empower", detail: "Synonyms: authorize, license, entitle, permit, allow, sanction, warrant, commission, delegate, certify, accredit, qualify"),
        Word(category:"Meaning: fill (someone) with great delight; charm", name:"Enchant", detail: "Synonyms: captivate, charm, delight, dazzle, enrapture, entrance, enthral, beguile, bewitch, spellbind, ensnare, fascinate, hypnotize, mesmerize"),
        Word(category:"Meaning: give support, confidence, or hope to (someone)", name:"Encourage", detail: "Synonyms: hearten, cheer, buoy up, uplift, inspire, motivate, egg on, spur on, stir, stir up, whip up, fire up, stimulate, animate, invigorate, vitalize"),
        Word(category:"Meaning: cause to be loved or liked", name:"Endear", detail: "Synonyms: Captivate, cherish, attach, bind, charm, engage"),
            Word(category:"Meaning: recommend (a product) in an advertisement", name:"Endorse", detail: "Synonyms: support, back, approve (of), be in agreement with, favour"),
            Word(category:"Meaning: the strength and vitality required for sustained physical or mental activity", name:"Energy", detail: "Synonyms: vitality, vigour, life, liveliness, animation, vivacity, spirit, spiritedness, fire, passion, ardour, zeal, verve, enthusiasm, zest, vibrancy, spark"),
            Word(category:"Meaning: occupy or attract (someone's interest or attention)", name:"Engage", detail: "Synonyms: capture, catch, arrest, grab, seize, draw, attract, gain, win, captivate, hold, grip, engross, absorb, occupy"),
            Word(category:"Meaning: intensify, increase, or further improve the quality, value, or extent of", name:"Enhance", detail: "Synonyms: increase, add to, intensify, magnify, amplify, inflate, strengthen, build up, supplement, augment, boost, upgrade, raise, lift, escalate"),
            Word(category:"Meaning: take delight or pleasure in (an activity or occasion)", name:"Enjoy", detail: "Synonyms: like, love, be fond of, be entertained by, be amused by, be pleased by, find/take pleasure in, be keen on, delight in, appreciate"),
            Word(category:"Meaning: improve or enhance the quality or value of", name:"Enrich", detail: "Synonyms: enhance, make richer, improve, add to, augment, supplement, complement, boost, upgrade, reinforce"),
            Word(category:"Meaning: a project or undertaking, especially a bold or complex one", name:"Enterprise", detail: "Synonyms: undertaking, endeavour, venture, pursuit, exercise, activity, operation, exploit, mission, deed, act, action, move, measure, task, business, affair"),
            Word(category:"Meaning: capture the fascinated attention of", name:"Enthral", detail: "Synonyms: captivate, charm, enchant, bewitch, fascinate, beguile, entrance, enrapture, delight, attract, allure, lure"),
            Word(category:"Meaning: intense and eager enjoyment, interest, or approval", name:"Enthusiasm", detail: "Synonyms: eagerness, keenness, ardour, fervour, warmth, passion, zeal, zealousness, zest, gusto, brio, pep, go, sap, liveliness, vivacity, vivaciousness, energy"),
            Word(category:"Meaning: a person who sets up a business or businesses, taking on financial risks in the hope of profit", name:"Entrepreneur", detail: "Synonyms: businessman, businesswoman, business person, business executive, enterpriser, speculator, tycoon, magnate"),
            Word(category:"Meaning: imagine as a future possibility", name:"Envision", detail: "Synonyms: visualize, imagine, envisage, picture, see in one's mind's eye, conjure up an image of"),
            Word(category:"Meaning: a person or thing that is a perfect example of a particular quality or type", name:"Epitome", detail: "Synonyms: personification, embodiment, incarnation, paragon"),
            Word(category:"Meaning: supply with the necessary items for a particular purpose", name:"Equip", detail: "Synonyms: provide, furnish, supply, issue, fit out, kit out, rig out, deck out, stock, provision, arm"),
            Word(category:"Meaning: absolutely necessary; extremely important",name:"Essential", detail: "Synonyms: crucial, necessary, key, vital, indispensable, needed, required, called for, requisite, important, all-important"),
            Word(category:"Meaning: set up on a firm or permanent basis", name:"Establish", detail: "Synonyms: set up, start, begin, get going, put in place, initiate, institute, form, found, create, bring into being, inaugurate, organize"),
            Word(category:"Meaning: relating to a population subgroup (within a larger or dominant national or cultural group) with a common national or cultural tradition", name:"Ethnic", detail: "Synonyms: racial, race-related, ethnological, genetic, inherited"),
            Word(category:"Meaning: the characteristic spirit of a culture, era, or community as manifested in its attitudes and aspirations", name:"Ethos", detail: "Synonyms: spirit, character, atmosphere, climate, prevailing tendency, mood, feeling, temper, tenor, flavour, essence, quintessence"),
            Word(category:"Meaning: form an idea of the amount, number, or value of; assess", name:"Evaluate", detail: "Synonyms: assess, assess the worth of, put a value/price on"),
            Word(category:"Meaning: bring or recall (a feeling, memory, or image) to the conscious mind", name:"Evoke", detail: "Synonyms: bring to mind, call to mind, put one in mind of, call up, conjure up, summon up, summon, invoke, give rise to, bring forth, elicit"),
            Word(category:"Meaning: accurate or correct in all details", name:"Exact", detail: "Synonyms:precise, accurate, correct, faithful, close, true, veracious, literal, strict, unerring, faultless, errorless, error-free"),
            Word(category:"Meaning: inspect (someone or something) thoroughly in order to determine their nature or condition", name:"Examine", detail: "Synonyms: inspect, survey, scrutinize, look at, look into, enquire into, study, investigate, scan, sift, delve into, dig into, explore, probe, check out, consider"),
            Word(category:"Meaning: be exceptionally good at or proficient in an activity or subject", name:"Excel", detail: "Synonyms: shine, be very good, be excellent, be brilliant, be outstanding, be skilful, be talented, be proficient, be expert, be pre-eminent, reign supreme, wear the crown"),
            Word(category:"Meaning: extremely good; outstanding", name:"Excellent", detail: "Synonyms: very good, superb, outstanding, magnificent, of high quality, of the highest quality, of the highest standard, exceptional, marvellous, wonderful, sublime"),
            Word(category:"Meaning: unusual; not typical", name:"Exceptional", detail: "Synonyms: unusual, uncommon, abnormal, atypical, extraordinary, out of the ordinary, out of the way, rare, singular, unprecedented, unexpected"),
            Word(category:"Meaning: causing great enthusiasm and eagerness", name:"Exciting", detail: "Synonyms: thrilling, exhilarating, stirring, rousing, stimulating, intoxicating, electrifying, invigorating, moving, inspiring"),
            Word(category:"Meaning: excluding or not admitting other things", name:"Exclusive", detail: "Synonyms: complete, full, entire, whole, total, absolute"),
            Word(category:"Meaning: serving as a desirable model; very good", name:"Exemplary", detail: "Synonyms: perfect, ideal, model, faultless, without fault, copybook, flawless, impeccable, consummate"),
            Word(category:"Meaning: including or considering all elements or aspects; fully comprehensive", name:"Exhaustive", detail: "Synonyms: comprehensive, all-inclusive, complete, full, full-scale, all-embracing, all-encompassing, encyclopedic, thorough, in-depth, thoroughgoing, extensive"),
            Word(category:"Meaning: making one feel very happy, animated, or elated", name:"Exhilarating", detail: "Synonyms: breathtaking, exciting, inspiring, intoxicating, invigorating, rousing, thrilling"),
                Word(category:"Meaning: practical contact with and observation of facts or events", name:"Experience", detail: "Synonyms: involvement in, participation in"),
                Word(category:"Meaning: a person who is very knowledgeable about or skilful in a particular area", name:"Expert", detail: "Synonyms: specialist, authority, pundit, oracle, resource person"),
                Word(category:"Meaning: make (an idea or situation) clear to someone by describing it in more detail or revealing relevant facts", name:"Explain", detail: "Synonyms: describe, give an explanation of, make clear/plain/intelligible, spell out, put into words, express in words"),
                Word(category:"Meaning: travel through (an unfamiliar area) in order to learn about it", name:"Explore", detail: "Synonyms: travel over, tour, traverse, range over"),
                Word(category:"Meaning: a person who supports an idea or theory and tries to persuade people of its truth or benefits", name:"Exponent", detail: "Synonyms: advocate, supporter, proponent, upholder, backer, defender, champion"),
                Word(category:"Meaning: present and explain (a theory or idea) in detail", name:"Expound", detail: "Synonyms: present, put forward, set forth, proffer, offer, advance, propose, propound, frame, give an account of, recount"),
                Word(category:"Meaning: effectively conveying thought or feeling", name:"Expressive", detail: "Synonyms: eloquent, meaningful, telling, revealing, demonstrative, suggestive"),
                Word(category:"Meaning: extremely beautiful and delicate", name:"Exquisite", detail: "Synonyms: beautiful, lovely, elegant, graceful"),
                Word(category:"Meaning: very unusual or remarkable", name:"Extraordinary", detail: "Synonyms: remarkable, exceptional, amazing, astonishing, astounding, marvellous, wonderful, sensational, stunning, incredible, unbelievable"),
                Word(category:"Meaning: full of energy, excitement, and cheerfulness", name:"Exuberant", detail: "Synonyms: ebullient, buoyant, cheerful, sunny, breezy, jaunty, light-hearted, in high spirits, high-spirited, exhilarated, excited, elated, exultant, euphoric, joyful"),
    
    
                //F
        
        Word(category:"Meaning: a cosmetic surgical operation to remove unwanted wrinkles by tightening the skin of the face", name:"Facelift", detail: "Synonyms: cosmetic surgery, plastic surgery"),
        Word(category:"Meaning: make (an action or process) easy or easier", name:"Facilitate", detail: "Synonyms: make easy/easier, ease, make possible, make smooth/smoother, smooth, smooth the path of, smooth the way for, clear the way for"),
        Word(category:"Meaning: a place, amenity, or piece of equipment provided for a particular purpose", name:"Facility", detail: "Synonyms: provision, space, means, solution, potential, prerequisite, equipment"),
        Word(category:"Meaning: a thing that is known or proved to be true", name:"Fact", detail: "Synonyms: reality, actuality, certainty, factuality, certitude"),
        Word(category:"Meaning: a circumstance, fact, or influence that contributes to a result", name:"Factor", detail: "Synonyms: element, part, component, ingredient, strand, constituent, point, detail, item, feature, facet, aspect, characteristic, consideration, influence"),
        Word(category:"Meaning: concerned with what is actually the case", name:"Factual", detail: "Synonyms: truthful, true, accurate, authentic, historical, genuine, fact-based, realistic, real"),
        Word(category:"Meaning: treating people equally without favouritism or discrimination", name:"Fair", detail: "Synonyms: just, equitable, fair-minded, open-minded, honest, upright, honourable, trustworthy"),
        Word(category:"Meaning: remaining loyal and steadfast", name:"Faithful", detail: "Synonyms: loyal, constant, true, devoted, true-blue, true-hearted, unswerving, unwavering, staunch, steadfast, dedicated, committed"),
        Word(category:"Meaning: known about by many people", name:"Famous", detail: "Synonyms: well known, celebrated, prominent, famed, popular, having made a name for oneself"),
        Word(category:"Meaning: at, to, or by a great distance (used to indicate the extent to which one thing is distant from another)", name:"Far", detail: "Synonyms: a long way, a great distance, a good way, afar"),
        Word(category:"Meaning: extremely interesting", name:"Fascinating", detail: "Synonyms: engrossing, captivating, absorbing, interesting, enchanting, beguiling, bewitching, enthralling, enrapturing, entrancing, spellbinding, transfixing"),
        Word(category:"Meaning: a popular or the latest style of clothing, hair, decoration, or behaviour", name:"Fashion", detail: "Synonyms: vogue, trend, craze, rage, mania, mode, fad, fancy, passing fancy"),
        Word(category:"Meaning: free from defect or error", name:"Faultless", detail: "Synonyms: perfect, flawless, without fault, error-free, without blemish, unblemished, impeccable, accurate, precise, exact, correct, unerring"),
        Word(category:"Meaning: approval, support, or liking for someone or something", name:"Favour", detail: "Synonyms: approval, approbation, commendation, esteem, goodwill, kindness, benevolence, friendliness"),
        Word(category:"Meaning: possible and practical to do easily or conveniently", name:"Feasible", detail: "Synonyms: practicable, practical, workable, achievable, attainable, realizable, viable, realistic, sensible, reasonable, within reason, within the bounds of possibility"),
        Word(category:"Meaning: a large meal, typically a celebratory one", name:"Feast", detail: "Synonyms: banquet, celebration meal, lavish dinner, sumptuous repast, large meal, formal meal, formal dinner"),
        Word(category:"Meaning: an achievement that requires great courage, skill, or strength", name:"Feat", detail: "Synonyms: achievement, accomplishment, attainment, coup, master stroke, triumph"),
        Word(category:"Meaning: a distinctive attribute or aspect of something", name:"Feature", detail: "Synonyms: characteristic, attribute, quality, property, trait, mark, hallmark, trademark"),
        Word(category:"Meaning: having or displaying a passionate intensity", name:"Fervent", detail: "Synonyms: impassioned, passionate, intense, vehement, ardent, sincere, feeling, profound, deep-seated, heartfelt, deeply felt, emotional, animated"),
        Word(category:"Meaning: a festival or gathering devoted to a particular activity or interest", name:"Fest", detail: "Synonyms: desolate, dumps, downcast, dysphoric, dejected"),
            Word(category:"Meaning: a day or period of celebration, typically for religious reasons", name:"Festival", detail: "Synonyms: fete, fair, gala day, gala, carnival, fiesta, jamboree, pageant"),
            Word(category:"Meaning: take part in a violent struggle involving the exchange of physical blows or the use of weapons", name:"Fight", detail: "Synonyms: brawl, come to blows, exchange blows, attack/assault each other, hit/punch each other"),
            Word(category:"Meaning: of very high quality; very good of its kind", name:"Fine", detail: "Synonyms: excellent, first-class, first-rate, great, exceptional, outstanding, admirable, quality, superior, splendid, magnificent, beautiful, exquisite"),
            Word(category:"Meaning: impressive delicacy and skill", name:"Finesse", detail: "Synonyms: skill, subtlety, expertise, flair, knack, panache, dash, flourish, elan, polish, adroitness, skilfulness, adeptness, artistry, art, artfulness"),
            Word(category:"Meaning: having a solid, almost unyielding surface or structure", name:"Firm", detail: "Synonyms: hard, solid, unyielding, resistant"),
            Word(category:"Meaning: a special or instinctive aptitude or ability for doing something well", name:"Flair", detail: "Synonyms: aptitude, talent, gift, knack, instinct, natural ability, ability, capability, capacity, faculty, facility, skill, bent, feel, genius"),
            Word(category:"Meaning: (of a person or their behaviour) tending to attract attention because of their exuberance, confidence, and stylishness", name:"Flamboyant", detail: "Synonyms: ostentatious, exuberant, confident, lively, buoyant, animated, energetic, vibrant, vivacious, extravagant, theatrical, showy, swashbuckling"),
            Word(category:"Meaning: lavish praise and compliments on (someone), often insincerely and with the aim of furthering one's own interests", name:"Flatter", detail: "Synonyms: compliment, praise, commend, admire, express admiration for, pay tribute to, say nice things about"),
            Word(category:"Meaning: the distinctive taste of a food or drink", name:"Flavour", detail: "Synonyms: taste, savour, tang, relish, palate"),
            Word(category:"Meaning: without any imperfections or defects; perfect", name:"Flawless", detail: "Synonyms: perfect, without blemish, unblemished, unmarked, unimpaired"),
            Word(category:"Meaning: capable of bending easily without breaking", name:"Flexible", detail: "Synonyms: pliable, supple, easily bent, bendable, pliant, malleable, mouldable, stretchable, workable, limber, ductile, tensile, plastic"),
            Word(category:"Meaning: (of a living organism) grow or develop in a healthy or vigorous way, especially as the result of a particularly congenial environment", name:"Flourish", detail: "Synonyms: grow, thrive, prosper, grow/do well, develop, burgeon, increase, multiply, proliferate"),
            Word(category:"Meaning: rise and fall irregularly in number or amount", name:"Fluctuate", detail: "Synonyms: vary, differ, shift, change, alter, waver, swing, oscillate, alternate, rise and fall, go up and down, see-saw, yo-yo, be unstable, be unsteady"),
            Word(category:"Meaning: able to express oneself easily and articulately", name:"Fluent", detail: "Synonyms: articulate, eloquent, expressive, communicative, coherent, cogent, illuminating"),
            Word(category:"Meaning: the centre of interest or activity", name:"Focus", detail: "Synonyms: centre, focal point, central point, centre of attention, hub, pivot, nucleus, heart, cornerstone, linchpin, kingpin, bedrock, basis"),
            Word(category:"Meaning: prevent (something considered wrong or undesirable) from succeeding", name:"Foil", detail: "Synonyms: thwart, frustrate, counter, oppose, baulk, disappoint, impede, obstruct, hamper, hinder, snooker, cripple, scotch, derail, smash, dash"),
            Word(category:"Meaning: strong and assertive; vigorous and powerful", name:"Forceful", detail: "Synonyms: dynamic, energetic, assertive, authoritative, vigorous, powerful, potent, strong, strong-willed, pushing, driving, determined, insistent, commanding, bullish"),
            Word(category:"Meaning: be aware of beforehand; predict", name:"Foresee", detail: "Synonyms: anticipate, predict, forecast, expect, envisage, envision, see, think likely"),
            Word(category:"Meaning: serving to form something, especially having a profound influence on a person's development", name:"Formative", detail: "Synonyms: developmental, developing, growing, mouldable, malleable, impressionable, susceptible"),
            Word(category:"Meaning: inspiring fear or respect through being impressively large, powerful, intense, or capable", name:"Formidable", detail: "Synonyms: intimidating, forbidding, redoubtable, daunting, alarming, frightening, terrifying, petrifying, horrifying, chilling, disturbing, disquieting, dreadful, brooding, awesome"),
                Word(category:"Meaning: a meeting or medium where ideas and views on a particular issue can be exchanged", name:"Forum", detail: "Synonyms: meeting, assembly, gathering, conference, seminar, convention, colloquy, convocation, congress, rally, council, symposium, conclave, congregation"),
                Word(category:"Meaning: in the direction that one is facing or travelling; towards the front", name:"Forward", detail: "Synonyms: ahead, forwards, onwards, onward, on, further"),
                Word(category:"Meaning: the lowest load-bearing part of a building, typically below ground level", name:"Foundation", detail: "Synonyms: footing, foot, base, substructure, understructure, underpinning"),
                Word(category:"Meaning: (of an object) easily broken or damaged", name:"Fragile", detail: "Synonyms: breakable, easily broken, brittle, frangible, smashable, splintery, flimsy, weak, frail, insubstantial, delicate, dainty, fine; eggshell"),
                Word(category:"Meaning: a pleasant, sweet smell", name:"Fragrance", detail: "Synonyms: sweet smell, scent, perfume, bouquet, aroma, odour, redolence, nose, balm, balminess"),
                    Word(category:"Meaning: an essential supporting structure of a building, vehicle, or object", name:"Framework", detail: "Synonyms: frame, substructure, structure, skeleton, chassis, shell, body, bodywork"),
                    Word(category:"Meaning: (of food) recently made or obtained; not tinned, frozen, or otherwise preserved", name:"Fresh", detail: "Synonyms: newly harvested, garden-fresh, not stale, crisp, firm, unwilted, unfaded"),
                    Word(category:"Meaning: (of a tree, plant, or land) producing much fruit; fertile", name:"Fruitful", detail: "Synonyms: fruit-bearing, fructiferous, fruiting"),
                    Word(category:"Meaning: achieve or realize (something desired, promised, or predicted)", name:"Fulfil", detail: "Synonyms: succeed in, attain, realize, consummate, satisfy, manage, bring off, bring about, carry off, carry out, carry through, bring to fruition, deliver"),
                    Word(category:"Meaning: complimentary or flattering to an excessive degree", name:"Fulsome", detail: "Synonyms: enthusiastic, ample, profuse, extensive, generous, liberal, lavish, glowing, gushing, gushy"),
                    Word(category:"Meaning: designed to be practical and useful, rather than attractive", name:"Functional", detail: "Synonyms: practical, useful, utilitarian, utility, workaday, serviceable"),
                    Word(category:"Meaning: forming a necessary base or core; of central importance", name:"Fundamental", detail: "Synonyms: basic, foundational, rudimentary, elemental, elementary, underlying, basal, radical, root"),

                    
                    //G
        
        
        Word(category:"Meaning: shock or excite (someone) into taking action.", name:"Galvanise", detail: "Synonyms: jolt, shock, startle, impel, stir, spur, prod, urge, motivate, stimulate, electrify, excite, rouse, arouse, awaken, invigorate, fire, fuel, animate, vitalize"),
        Word(category:"Meaning: characteristic of or relating to a class or group of things; not specific", name:"Generic", detail: "Synonyms: general, common, collective, non-specific, inclusive, all-inclusive, all-encompassing, broad, comprehensive, blanket, umbrella, sweeping"),
        Word(category:"Meaning: showing a readiness to give more of something, especially money, than is strictly necessary or expected", name:"Generous", detail: "Synonyms: liberal, lavish, magnanimous, munificent, giving, open-handed, free-handed, bountiful, unselfish, ungrudging, unstinting, unsparing"),
        Word(category:"Meaning: a style or category of art, music, or literature", name:"Genre", detail: "Synonyms: category, class, classification, categorization, group, grouping, bracket, head, heading, list, listing, set"),
        Word(category:"Meaning: truly what something is said to be; authentic", name:"Genuine", detail: "Synonyms: authentic, real, actual, original, pukka, bona fide, true, veritable, unfeigned, unadulterated, unalloyed"),
        Word(category:"Meaning: relevant to a subject under consideration", name:"Germane", detail: "Synonyms: relevant, pertinent, applicable, apposite, material"),
        Word(category:"Meaning: an attractive or exciting quality that makes certain people or things seem appealing", name:"Glamour", detail: "Synonyms: allure, attraction, attractiveness, fascination, charm, enchantment, captivation, magic, romance, mystique, exoticism, spell"),
        Word(category:"Meaning: high renown or honour won by notable achievements", name:"Glory", detail: "Synonyms: renown, fame, prestige, honour, distinction, kudos, eminence, pre-eminence, acclaim, acclamation, celebrity, praise, accolades, laurels, recognition"),
        Word(category:"Meaning: move from one place to another; travel", name:"Go", detail: "Synonyms: move, proceed, make one's way, advance, progress, pass, walk, wend one's way"),
        Word(category:"Meaning: the object of a person's ambition or effort; an aim or desired result", name:"Goal", detail: "Synonyms: aim, objective, object, grail, holy grail, end, target, design, desire, desired result, intention, intent, plan, purpose, idea, point, object of the exercise"),
        Word(category:"Meaning: smoothness and elegance of movement", name:"Grace", detail: "Synonyms: elegance, stylishness, poise, finesse, charm"),
        Word(category:"Meaning: magnificent and imposing in appearance, size, or style", name:"Grand", detail: "Synonyms: magnificent, imposing, impressive, awe-inspiring, splendid, resplendent, superb, striking, monumental, majestic, glorious"),
        Word(category:"Meaning: give (someone) pleasure or satisfaction", name:"Gratify", detail: "Synonyms: please, gladden, give pleasure to, make happy, make content, delight, make someone feel good, satisfy, warm the cockles of the heart, thrill"),
        Word(category:"Meaning: dignity, seriousness, or solemnity of manner", name:"Gravitas", detail: "Synonyms: dignity, seriousness, solemnity, gravity, loftiness, grandeur, decorum, sobriety, sedateness"),
        Word(category:"Meaning: a formal assurance (typically in writing) that certain conditions will be fulfilled, especially that a product will be repaired or replaced if not of a specified quality", name:"Guarantee", detail: "Synonyms: warranty, warrant, contract, covenant, bond, assurance, promise"),
        Word(category:"Meaning: a person who shows the way to others, especially one employed to show tourists around places of interest", name:"Guide", detail: "Synonyms: escort, attendant, conductor, courier, pilot, usher, chaperone"),

        
        //H
        
        
        Word(category:"Meaning: denoting a period of time in the past that was idyllically happy and peaceful", name:"Halcyon", detail: "Synonyms: serene, calm, pleasant, balmy, tranquil, peaceful, temperate, mild, quiet, gentle, placid, still, windless, stormless"),
        Word(category:"Meaning: a mark stamped on articles of gold, silver, or platinum by the British assay offices, certifying their standard of purity", name:"Hallmark", detail: "Synonyms: assay mark, official mark, authentication mark, stamp of authenticity, stamp of authentication"),
        Word(category:"Meaning: the combination of simultaneously sounded musical notes to produce a pleasing effect", name:"Harmony", detail: "Synonyms: euphony, polyphony, consonance"),
        Word(category:"Meaning: the process or period of gathering in crops", name:"Harvest", detail: "Synonyms: gathering in of the crops, harvesting, harvest time, harvest home"),
        Word(category:"Meaning: the state of being free from illness or injury", name:"Health", detail: "Synonyms: good physical condition, healthiness, fitness, physical fitness, well-being, haleness, good trim, good shape, fine fettle, good kilter"),
        Word(category:"Meaning: a hollow muscular organ that pumps the blood through the circulatory system by rhythmic contraction and dilation. In vertebrates there may be up to four chambers (as in humans), with two atria and two ventricles", name:"Heart", detail: "Synonyms: informal-ticker"),
        Word(category:"Meaning: make or become more intense", name:"Heighten", detail: "Synonyms: intensify, increase, enhance, make greater, add to, raise, augment, boost, strengthen, sharpen, deepen, magnify, amplify"),
        Word(category:"Meaning: an official employed to oversee state ceremonial, precedence, and the use of armorial bearings, and (historically) to make proclamations, carry official messages, and oversee tournaments", name:"Herald", detail: "Synonyms: messenger, courier, bearer of tidings"),
        Word(category:"Meaning: property that is or may be inherited; an inheritance", name:"Heritage", detail: "Synonyms: inheritance, birthright, patrimony"),
        Word(category:"Meaning: an outstanding part of an event or period of time", name:"Highlight", detail: "Synonyms: high point, high spot, best part, climax, culmination, peak, pinnacle, height, top, acme, zenith, apex, summit, apogee, apotheosis"),
        Word(category:"Meaning: famous or important in history, or potentially so", name:"Historic", detail: "Synonyms: famous, famed, important, significant, notable, celebrated, renowned, momentous, headline, consequential, outstanding, extraordinary, memorable"),
        Word(category:"Meaning: incorporating the concept of holism or the idea that the whole is more than merely the sum of its parts, in theory or practice", name:"Holistic", detail: "Synonyms: comprehensive, integrated, aggregate, entire, full, universal"),
            Word(category:"Meaning: free of deceit; truthful and sincere", name:"Honest", detail: "Synonyms: truthful, sincere, candid, frank, direct, open, forthright, straight, straightforward, genuine, blunt, plain-spoken, plain-speaking"),
            Word(category:"Meaning: high respect; great esteem", name:"Honour", detail: "Synonyms: distinction, privilege, glory, tribute, kudos, cachet, prestige, fame, renown, merit, credit, importance, illustriousness, notability"),
            Word(category:"Meaning: a feeling of expectation and desire for a particular thing to happen", name:"Hope", detail: "Synonyms: aspiration, desire, wish, expectation, ambition, aim, plan, dream, daydream, pipe dream"),
            Word(category:"Meaning: the line at which the earth's surface and the sky appear to meet", name:"Horizon", detail: "Synonyms: skyline, range of vision, field of view, vista, view"),
            Word(category:"Meaning: the central part of a wheel, rotating on or with the axle, and from which the spokes radiate", name:"Hub", detail: "Synonyms: pivot, axis, fulcrum, centre, centre point"),
            Word(category:"Meaning: having or showing compassion or benevolence", name:"Humane", detail: "Synonyms: compassionate, kind, kindly, kind-hearted, considerate, understanding, sympathetic, tolerant, civilized, good, good-natured, gentle"),
            Word(category:"Meaning: conditions or practices conducive to maintaining health and preventing disease, especially through cleanliness", name:"Hygiene", detail: "Synonyms: cleanliness, personal hygiene, personal cleanliness, purity, sterility, disinfection, sanitation, sanitariness"),

            
            //I
        
        Word(category:"Meaning: a devotional painting of Christ or another holy figure, typically executed on wood and used ceremonially in the Byzantine and other Eastern Churches", name:"Icon", detail: "Synonyms: image, idol, portrait, likeness, representation, symbol, figure, statue, model"),
        Word(category:"Meaning: satisfying one's conception of what is perfect; most suitable", name:"Ideal", detail: "Synonyms: perfect, best possible, consummate, supreme, absolute, complete, copybook, flawless, faultless, without fault, exemplary, classic, archetypal"),
        Word(category:"Meaning: establish or indicate who or what (someone or something) is", name:"Identify", detail: "Synonyms: recognize, single out, pick out, spot, point out, pinpoint, pin down, put one's finger on, put a name to, name, place, know, know again"),
        Word(category:"Meaning: like an idyll; extremely happy, peaceful, or picturesque", name:"Idyllic", detail: "Synonyms: perfect, ideal, idealized, wonderful, blissful, halcyon, happy"),
        Word(category:"Meaning: light up", name:"Illuminate", detail: "Synonyms: light, light up, throw light on, cast light upon, brighten, make brighter, shine on, flood with light, floodlight, irradiate"),
        Word(category:"Meaning: provide (a book, newspaper, etc.) with pictures", name:"Illustrate", detail: "Synonyms: decorate, adorn, ornament, embellish, accompany"),
        Word(category:"Meaning: a representation of the external form of a person or thing in art.", name:"Image", detail: "Synonyms: likeness, resemblance"),
            Word(category:"Meaning: form a mental image or concept of", name:"Imagine", detail: "Synonyms: visualize, envisage, envision, picture, form a picture of, see in the mind's eye, conjure up, conceptualize"),
            Word(category:"Meaning: perfectly clean, neat, or tidy", name:"Immaculate", detail: "Synonyms: clean, spotless, pristine, unsoiled, unstained, unsullied, speckless, ultra-clean"),
            Word(category:"Meaning: the action of one object coming forcibly into contact with another", name:"Impact", detail: "Synonyms: collision, crash, smash, clash, bump, bang, knock, jolt, thump, whack, thwack, slam, smack; contact"),
            Word(category:"Meaning: treating all rivals or disputants equally", name:"Impartial", detail: "Synonyms: unbiased, unprejudiced, neutral, non-partisan, non-discriminatory, anti-discrimination, disinterested, uninvolved, uncommitted, detached"),
            Word(category:"Meaning: in accordance with the highest standards; faultless", name:"Impeccable", detail: "Synonyms: flawless, faultless, unblemished, spotless, stainless, untarnished, perfect, exemplary, ideal, model"),
            Word(category:"Meaning: the force or energy with which a body moves", name:"Impetus", detail: "Synonyms: momentum, propulsion, impulsion, impelling force, motive force, driving force, drive, thrust, continuing motion"),
            Word(category:"Meaning: a tool, utensil, or other piece of equipment that is used for a particular purpose", name:"Implement", detail: "Synonyms: tool, utensil, instrument, device, apparatus, contrivance, gadget, contraption, appliance, machine, labour-saving device"),
            Word(category:"Meaning: indicate the truth or existence of (something) by suggestion rather than explicit reference", name:"Imply", detail: "Synonyms: implicit, indirect, hinted, suggested, insinuated, deducible, inferred, understood"),
            Word(category:"Meaning: of great significance or value", name:"Important", detail: "Synonyms: main, chief, principal, key, major, salient, prime, dominant, foremost, supreme, predominant, paramount, overriding, cardinal, crucial"),
            Word(category:"Meaning: grand and impressive in appearance", name:"Imposing", detail: "Synonyms: impressive, striking, arresting, eye-catching, dramatic, spectacular, staggering, stunning, awesome, awe-inspiring, remarkable, formidable"),
            Word(category:"Meaning: evoking admiration through size, quality, or skill; grand, imposing, or awesome", name:"Impressive", detail: "Synonyms: magnificent, majestic, imposing, splendid, spectacular, grand, august, awe-inspiring, stirring, stunning, breathtaking"),
            Word(category:"Meaning: make or become better", name:"Improve", detail: "Synonyms: make better, better, ameliorate, upgrade, refine, enhance, boost, build on, help, raise, revamp, brush up, polish up, perk up, tweak"),
            Word(category:"Meaning: a thing that motivates or encourages someone to do something", name:"Incentive", detail: "Synonyms: inducement, motivation, motive, reason, stimulus, stimulant, spur, impetus, encouragement, impulse"),
            Word(category:"Meaning: (of a person or mental process) intelligently analytical and clear-thinking", name:"Incisive", detail: "Synonyms: penetrating, acute, sharp, sharp-witted, razor-sharp, keen, rapier-like, astute, shrewd, trenchant, piercing, perceptive, insightful, percipient"),
            Word(category:"Meaning: including all the services or items normally expected or required", name:"Inclusive", detail: "Synonyms: all-in, all-inclusive, with everything included, comprehensive, in toto"),
            Word(category:"Meaning: without an equal in quality or extent; matchless", name:"Incomparable", detail: "Synonyms: without equal, beyond compare, unparalleled, matchless, peerless, without peer, unmatched, without match, without parallel, beyond comparison"),
            Word(category:"Meaning: not able to be denied or disputed", name:"Incontrovertible", detail: "Synonyms: indisputable, incontestable, undeniable, irrefutable, unassailable, beyond dispute, unquestionable, beyond question, indubitable, not in doubt"),
            Word(category:"Meaning: free from outside control; not subject to another's authority", name:"Independent", detail: "Synonyms: freethinking, individualistic, unconventional, maverick"),
            Word(category:"Meaning: originating or occurring naturally in a particular place; native", name:"Indigenous", detail: "Synonyms: native, aboriginal, local"),
            Word(category:"Meaning: absolutely necessary", name:"Indispensable", detail: "Synonyms: essential, crucial, necessary, key, vital, needed, required, called for, requisite, important, all-important, vitally important, of the utmost importance"),
            Word(category:"Meaning: unable to be challenged or denied", name:"Indisputable", detail: "Synonyms: incontrovertible, incontestable, undeniable, irrefutable, unassailable, beyond dispute, unquestionable, beyond question, indubitable"),
            Word(category:"Meaning: single; separate", name:"Individual", detail: "Synonyms: single, separate, discrete, independent"),
            Word(category:"Meaning: succeed in persuading or leading (someone) to do something", name:"Induce", detail: "Synonyms: persuade, convince, prevail upon, get, make, prompt, move, inspire, instigate, influence, exert influence on, press, urge, incite"),
            Word(category:"Meaning: diligent and hard-working", name:"Industrious", detail: "Synonyms: hard-working, diligent, assiduous, sedulous, conscientious, steady, painstaking, persistent, persevering, pertinacious, unflagging, untiring, tireless"),
                Word(category:"Meaning: unable to be avoided or denied", name:"Inescapable", detail: "Synonyms: unavoidable, inevitable, ineluctable, ineliminable, inexorable, assured, sure, certain, bound to happen, sure to happen, unpreventable, preordained, predestined"),
                Word(category:"Meaning: certain to happen; unavoidable", name:"Inevitable", detail: "Synonyms: unavoidable, inescapable, bound to happen, sure to happen, inexorable, unpreventable, assured, certain, for sure, sure, fated"),
                Word(category:"Meaning: impossible to stop or prevent", name:"Inexorable", detail: "Synonyms: relentless, unstoppable, unavoidable, inescapable, inevitable, irrevocable"),
                Word(category:"Meaning: the capacity to have an effect on the character, development, or behaviour of someone or something, or the effect itself", name:"Influence", detail: "Synonyms: effect, impact"),
                    Word(category:"Meaning: give (someone) facts or information", name:"Inform", detail: "Synonyms: tell, let someone know, notify, apprise, advise, announce to, impart to, communicate to"),
                    Word(category:"Meaning: (of a person) clever, original, and inventive", name:"Ingenious", detail: "Synonyms: inventive, creative, imaginative, original, innovative, resourceful, enterprising, insightful, inspired, perceptive, intuitive"),
                    Word(category:"Meaning: existing in something as a permanent, essential, or characteristic attribute", name:"Inherent", detail: "Synonyms: intrinsic, innate, immanent, built-in, inborn, ingrained, deep-rooted"),
                    Word(category:"Meaning: so good or unusual as to be impossible to copy; unique", name:"Inimitable", detail: "Synonyms: unique, distinctive, individual, special, idiosyncratic, quirky, exclusive, rare"),
                    Word(category:"Meaning: the ability to assess and initiate things independently", name:"Initiative", detail: "Synonyms: enterprise, inventiveness, resourcefulness, capability"),
                    Word(category:"Meaning: inborn", name:"Innate", detail: "Synonyms: inborn, natural, inbred, congenital, inherent, intrinsic, instinctive, intuitive, spontaneous, unlearned, untaught"),
                    Word(category:"Meaning: the action or process of innovating", name:"Innovation", detail: "Synonyms: change, alteration, revolution, upheaval, transformation, metamorphosis, reorganization, restructuring, rearrangement, recasting, remodelling, renovation"),
                    Word(category:"Meaning: the capacity to gain an accurate and deep understanding of someone or something", name:"Insight", detail: "Synonyms: intuition, perception, awareness, discernment, understanding, comprehension, apprehension, appreciation, cognizance, penetration, acumen"),
                    Word(category:"Meaning: look at (someone or something) closely, typically to assess their condition or to discover any shortcomings", name:"Inspect", detail: "Synonyms: examine, check (over), scrutinize, vet, investigate, test, monitor, survey, study, go over, look over, look at, take a look at, pore over"),
                    Word(category:"Meaning: fill (someone) with the urge or ability to do or feel something, especially to do something creative", name:"Inspire", detail: "Synonyms: stimulate, motivate, cause, incline, persuade, encourage, influence, rouse, move, stir, spur (on), goad, energize, galvanize, incite, impel"),
                    Word(category:"Meaning: useful and informative", name:"Instructive", detail: "Synonyms: informative, instructional, informational, illuminating, enlightening, revealing, explanatory, telling"),
                    Word(category:"Meaning: necessary to make a whole complete; essential or fundamental", name:"Integral", detail: "Synonyms: essential, fundamental, basic, intrinsic, inherent, constitutive, innate, structural"),
                    Word(category:"Meaning: combine (one thing) with another to form a whole", name:"Integrate", detail: "Synonyms: combine, amalgamate, merge, unite, join, fuse, blend, mingle, coalesce, consolidate, meld, intermingle, mix, intermix, incorporate, affiliate"),
                    Word(category:"Meaning: the quality of being honest and having strong moral principles", name:"Integrity", detail: "Synonyms: honesty, uprightness, probity, rectitude, honour, honourableness, upstandingness, good character, principle(s), ethics, morals, righteousness"),
                    Word(category:"Meaning: having or showing intelligence, especially of a high level", name:"Intelligent", detail: "Synonyms: clever, bright, brilliant, sharp, quick, quick-witted, quick on the uptake, smart, canny, astute, intuitive, thinking, acute, alert, keen, insightful, perceptive"),
                    Word(category:"Meaning: become or make more intense", name:"Intensify", detail: "Synonyms: escalate, step up, boost, increase, raise, sharpen, strengthen, augment, add to, concentrate, reinforce"),
                    Word(category:"Meaning: intensification", name:"Intension", detail: "Synonyms: Indention, Intonation, Intentions, Inattention, Intrusion, intorsion"),
                        Word(category:"Meaning: (of two people or things) influencing each other", name:"Interactive", detail: "Synonyms: bilateral, collective, reciprocal, associated, communal, conjoint, conjunct, connected, convertible, correlative"),
                        Word(category:"Meaning: the feeling of wanting to know or learn about something or someone", name:"Interest", detail: "Synonyms: attentiveness, undivided attention, absorption, engrossment, heed, regard, notice, scrutiny"),
                        Word(category:"Meaning: a point where two systems, subjects, organizations, etc. meet and interact", name:"Interface", detail: "Synonyms: alliance, annexation, articulation, bond, dovetail"),
                        Word(category:"Meaning: an intervening period of time; an interval", name:"Interlude", detail: "Synonyms: interval, intermission, break, recess, pause, respite, rest, breathing space, halt, gap, stop, stoppage, hiatus, lull"),
                        Word(category:"Meaning: elating to relationships or communication between people", name:"Interpersonal", detail: "Synonyms: social, mutual, relational, civil, communal"),
                        Word(category:"Meaning: explain the meaning of (information or actions)", name:"Interpret", detail: "Synonyms: explain, elucidate, expound, explicate, clarify, make clear, make plain, illuminate, shed light on, throw light on"),
                        Word(category:"Meaning: closely acquainted; familiar", name:"Intimate", detail: "Synonyms: close, bosom, boon, dear, cherished, familiar, confidential, faithful, constant, devoted, fast, firm, favourite, special"),
                        Word(category:"Meaning: fearless; adventurous (often used for rhetorical or humorous effect)", name:"Intrepid", detail: "Synonyms: fearless, unafraid, undaunted, dauntless, undismayed, unalarmed, unflinching, unshrinking, unblenching, unabashed, bold, daring, audacious"),
                        Word(category:"Meaning: very complicated or detailed", name:"Intricate", detail: "Synonyms: complex, complicated, convoluted, tangled, entangled, ravelled, twisted, knotty, maze-like, labyrinthine, winding, serpentine, circuitous, sinuous"),
                        Word(category:"Meaning: arouse the curiosity or interest of; fascinate", name:"Intrigue", detail: "Synonyms: interest, be of interest to, fascinate, be a source of fascination to, arouse someone's curiosity, engage someone's attention, attract, draw"),
                        Word(category:"Meaning: belonging naturally; essential", name:"Intrinsic", detail: "Synonyms: inherent, innate, inborn, inbred, congenital, natural, native, constitutional, built-in, ingrained, deep-rooted, inseparable, permanent"),
                        Word(category:"Meaning: the ability to understand something instinctively, without the need for conscious reasoning", name:"Intuition", detail: "Synonyms: instinct, intuitiveness"),
                        Word(category:"Meaning: showing creativity or original though", name:"Inventive", detail: "Synonyms: creative, original, innovational, innovative, imaginative, fertile, ingenious, resourceful"),
                        Word(category:"Meaning: impossible to replace if lost or damaged", name:"Irreplaceable", detail: "Synonyms: unique, unrepeatable, incomparable, unparalleled, priceless, invaluable, beyond price, without price, inestimably precious, of incalculable value/worth"),
                        Word(category:"Meaning: too attractive and tempting to be resisted", name:"Irresistible", detail: "Synonyms: tempting, enticing, alluring, inviting, seductive"),
                        
                        
                        
                        
                        //K
                        
                        
                        Word(category:"Meaning: a small piece of shaped metal with incisions cut to fit the wards of a particular lock, which is inserted into a lock and turned to open or close it", name:"Key", detail: "Synonyms: answer, clue, solution, explanation, pointer, cue, lead"),
                        Word(category:"Meaning: a prevailing tone or central theme", name:"Keynote", detail: "Synonyms: theme, salient point, point, gist, substance, burden, tenor, heart of the matter, pith, marrow, topic, policy line"),
                        
                        
                        
                        //L
                        
                        Word(category:"Meaning: an object or feature of a landscape or town that is easily seen and recognized from a distance, especially one that enables someone to establish their location", name:"Landmark", detail: "Synonyms: marker, mark, indicator, guiding light, leading light, signal, beacon, lodestar, sign"),
                        Word(category:"Meaning: sumptuously rich, elaborate, or luxurious", name:"Lavish", detail: "Synonyms: sumptuous, luxurious, luxuriant, lush, gorgeous, costly, opulent, grand, elaborate, splendid, rich, regal, ornate, expensive"),
                        Word(category:"Meaning: the person who leads or commands a group, organization, or country", name:"Leader", detail: "Synonyms: chief, head, principal, boss"),
                        Word(category:"Meaning: the action of leading a group of people or an organization, or the ability to do this", name:"Leadership", detail: "Synonyms: guidance, direction, authority, control, management, superintendence, supervision"),
                        Word(category:"Meaning: most important", name:"Leading", detail: "Synonyms: main, chief, major, prime, most significant, principal, foremost, key, supreme, paramount, dominant, superior, ruling, directing"),
                        Word(category:"Meaning: the acquisition of knowledge or skills through study, experience, or being taught", name:"Learning", detail: "Synonyms: study, studying, education, schooling, tuition, teaching, academic work, instruction, training"),
                        Word(category:"Meaning: a traditional story sometimes popularly regarded as historical but not authenticated", name:"Legend", detail: "Synonyms: myth, saga, epic, folk tale, folk story, traditional story, tale, story, fairy tale, narrative, fable, romance"),
                        Word(category:"Meaning: conforming to the law or to rules", name:"Legitimate", detail: "Synonyms: legal, lawful, licit, legalized, authorized, permitted, permissible, allowable, allowed, admissible, recognized, sanctioned, approved, licensed"),
                        Word(category:"Meaning: the exertion of force by means of a lever", name:"Leverage", detail: "Synonyms: grip, purchase, hold, grasp"),
                        Word(category:"Meaning: of or according to the rules of logic or formal argument", name:"Logical", detail: "Synonyms: reasoning, thinking, straight-thinking, rational, objective, analytical, cerebral, insightful"),
                        Word(category:"Meaning: giving or showing firm and constant support or allegiance to a person or institution", name:"Loyal", detail: "Synonyms: faithful, true, true-hearted, tried and true, true-blue, devoted"),
                        Word(category:"Meaning: producing a great deal of profit", name:"Lucrative", detail: "Synonyms: profitable, profit-making, gainful, remunerative, moneymaking, paying, high-income, well paid, high-paying, bankable, cost-effective"),
                        Word(category:"Meaning: a state of great comfort or elegance, especially when involving great expense", name:"Luxury", detail: "Synonyms: opulence, luxuriousness, sumptuousness, richness, costliness, grandeur, grandness, splendour, magnificence, lavishness, lap of luxury"),
                        
                        
                        
                        
                        //M
                        
                        Word(category:"Meaning: generous or forgiving, especially towards a rival or less powerful person", name:"Magnanimous", detail: "Synonyms: generous, charitable, benevolent, beneficent, open-handed, big-hearted, great-hearted, munificent, bountiful, liberal, handsome, princely"),
                        Word(category:"Meaning: extremely beautiful, elaborate, or impressive", name:"Magnificent", detail: "Synonyms: splendid, spectacular, impressive, striking, glorious, superb, majestic, awesome, awe-inspiring, breathtaking"),
                        Word(category:"Meaning: having or showing impressive beauty or scale", name:"Majestic", detail: "Synonyms: exalted, august, great, awesome, elevated, sublime, lofty"),
                        Word(category:"Meaning: important, serious, or significant", name:"Major", detail: "Synonyms: crucial, vital, great, considerable, paramount, utmost, prime, extensive"),
                        Word(category:"Meaning: be in charge of (a business, organization, or undertaking)", name:"Manage", detail: "Synonyms: be in charge of, run, be head of, head, direct, control, preside over, lead, govern, rule, command, superintend, supervise, oversee, administer"),
                        Word(category:"Meaning: required by law or mandate; compulsory", name:"Mandatory", detail: "Synonyms: obligatory, compulsory, binding, required"),
                        Word(category:"Meaning: relating to or at the edge or margin", name:"Marginal", detail: "Synonyms: slight, small, tiny, minute, low, minor, insignificant, minimal, negligible"),
                        Word(category:"Meaning: showing great skill; very accomplished", name:"Masterly", detail: "Synonyms: expert, adept, clever, masterful"),
                        Word(category:"Meaning: a person with an outstanding intellect", name:"Mastermind", detail: "Synonyms: genius, mind, intellect, author, architect, engineer, director, planner, organizer, deviser, originator, manager, prime mover, initiator, inventor"),
                        Word(category:"Meaning: a work of outstanding artistry, skill, or workmanship", name:"Masterpiece", detail: "Synonyms: triumph, coup, marvellous feat, feather in one's cap, wonder, sensation, outstanding example, paragon, great work, showpiece, gem, prize"),
                        Word(category:"Meaning: fully developed physically; full-grown", name:"Mature", detail: "Synonyms: adult, grown-up, grown, fully grown, full-grown, of age, fully developed, fully fledged, in one's prime, in full bloom, nubile"),
                        Word(category:"Meaning: having meaning", name:"Meaningful", detail: "Synonyms: significant, relevant, important, consequential, material, telling, pithy, weighty, valid, worthwhile, purposeful"),
                        Word(category:"Meaning: ascertain the size, amount, or degree of (something) by using an instrument or device marked in standard units", name:"Measure", detail: "Synonyms: take the measurements of, calculate, compute, estimate, count, meter, quantify, weigh, size, evaluate, rate, assess, appraise, gauge, plumb"),
                        Word(category:"Meaning: intervene in a dispute in order to bring about an agreement or reconciliation", name:"Mediate", detail: "Synonyms: arbitrate, conciliate, moderate, umpire, referee, act as peacemaker, reconcile differences, restore harmony, make peace, bring to terms, liaise"),
                        Word(category:"Meaning: a varied mixture of people or things", name:"Medley", detail: "Synonyms: assortment, miscellany, mixture, melange, blend, variety, mixed bag, mix, diversity, collection, selection, assemblage, combination, motley collection, potpourri, conglomeration, jumble, mess, confusion"),
                        Word(category:"Meaning: (especially of a sound, flavour, or colour) pleasantly smooth or soft; free from harshness", name:"Mellow", detail: "Synonyms: dulcet, sweet-sounding, tuneful, euphonious, lyric, melodious, mellifluous"),
                        Word(category:"Meaning: combine or cause to combine to form a single entity", name:"Merge", detail: "Synonyms: join (together), join forces, amalgamate, consolidate, integrate, unite, unify, combine, incorporate, affiliate, coalesce, meld, agglutinate, team up"),
                        Word(category:"Meaning: done according to a systematic or established procedure", name:"Methodical", detail: "Synonyms: orderly, well ordered, well organized, well thought out, planned, well planned, efficient, businesslike, coherent, systematic, scientific, structured, logical"),
                        Word(category:"Meaning: showing great attention to detail; very careful and precise", name:"Meticulous", detail: "Synonyms: careful, conscientious, diligent, ultra-careful, scrupulous, punctilious, painstaking, demanding, exacting, accurate, correct"),
                        Word(category:"Meaning: a person's social environment", name:"Milieu", detail: "Synonyms: environment, background, backdrop, setting, context, atmosphere, scene"),
                        Word(category:"Meaning: inclined to think in a particular way", name:"Minded", detail: "Synonyms: determined, inclined, contemplating, convinced, decided, disposed, intending, willing"),
                        Word(category:"Meaning: conscious or aware of something", name:"Mindful", detail: "Synonyms: aware of, conscious of, alive to, sensible of, alert to, awake to, acquainted with, heedful of, watchful of, careful of, wary of, chary of, cognizant of"),
                        Word(category:"Meaning: an important assignment given to a person or group of people, typically involving travel abroad", name:"Mission", detail: "Synonyms: assignment, commission, expedition, journey, trip, errand, undertaking, operation"),
                        Word(category:"Meaning: (of a country or its government) prepare and organize (troops) for active service", name:"Mobilize", detail: "Synonyms:marshal, deploy, muster, rally, call to arms, call up, summon, assemble, mass, organize, make ready, prepare, ready"),
                        Word(category:"Meaning: a three-dimensional representation of a person or thing or of a proposed structure, typically on a smaller scale than the original", name:"Model", detail: "Synonyms: replica, copy, representation, mock-up, dummy, imitation, double, duplicate, lookalike, reproduction"),
                        Word(category:"Meaning: average in amount, intensity, quality, or degree", name:"Moderate", detail: "Synonyms: average, modest, medium, middling, ordinary, common, commonplace, everyday, workaday"),
                        Word(category:"Meaning: relating to the present or recent times as opposed to the remote past", name:"Modern", detail: "Synonyms: present-day, contemporary, present-time, present, current, twenty-first-century, latter-day, recent"),
                        Word(category:"Meaning: unassuming in the estimation of one's abilities or achievements", name:"Modest", detail: "Synonyms: self-effacing, self-deprecating, humble, unpretentious, unassuming, unpresuming, unostentatious, low-key, free from vanity, keeping one's light under a bushel"),
                        Word(category:"Meaning: make partial or minor changes to (something)", name:"Modify", detail: "Synonyms: alter, make alterations to, change, adjust, make adjustments to, adapt, amend, improve, revise, recast, reform, reshape, refashion, redesign, restyle, revamp"),
                        Word(category:"Meaning: of great importance or significance, especially in having a bearing on future events", name:"Momentous", detail: "Synonyms: important, significant, epoch-making, historic, apocalyptic, headline, fateful, portentous, critical, crucial, vital, life-and-death, decisive, pivotal, serious"),
                        Word(category:"Meaning: the impetus and driving force gained by the development of a process or course of events", name:"Momentum", detail: "Synonyms: impetus, energy, force, power, strength, drive, thrust, push, driving power, steam, impulse, speed, velocity"),
                        Word(category:"Meaning: a device used for observing, checking, or keeping a continuous record of something", name:"Monitor", detail: "Synonyms: detector, scanner, recorder"),
                        Word(category:"Meaning: the confidence, enthusiasm, and discipline of a person or group at a particular time", name:"Morale", detail: "Synonyms: confidence, self-confidence, self-esteem"),
                        Word(category:"Meaning: a picture or pattern produced by arranging together small pieces of stone, tile, glass, etc", name:"Mosaic", detail: "Synonyms: patchwork, checker, montage, motley, plaid"),
                        Word(category:"Meaning: a decorative image or design, especially a repeated one forming a pattern", name:"Motif", detail: "Synonyms: design, pattern, decoration, figure, shape, logo, monogram, device, emblem, ornament"),
                        Word(category:"Meaning: provide (someone) with a reason for doing something", name:"Motivate", detail: "Synonyms: prompt, drive, move, inspire, stimulate, influence, lead, persuade, actuate, activate, impel, push, propel"),
                        Word(category:"Meaning: having many sides", name:"Multifaceted", detail: "Synonyms: all-round, varied, various, able, adroit, facile, gifted"),
                        Word(category:"Meaning: (of a feeling or action) experienced or done by each of two or more parties towards the other or others", name:"Mutual", detail: "Synonyms: reciprocal, reciprocated, requited, returned, give-and-take, interchangeable, interactive, complementary, correlative"),
                        
                        
                        
                        //N
                        
                        Word(category:"Meaning: having had a minimum of processing or preservative treatment", name:"Natural", detail: "Synonyms: unprocessed, organic, pure, wholesome, unrefined, pesticide-free, chemical-free, additive-free, unbleached, unmixed, real, plain, virgin, crude, raw"),
                        Word(category:"Meaning: arranged in a tidy way; in good order", name:"Neat", detail: "Synonyms: tidy, neat and tidy, as neat as a new pin, orderly, well ordered, in (good) order, well kept, shipshape (and Bristol fashion), in apple-pie order"),
                        Word(category:"Meaning: so small or unimportant as to be not worth considering; insignificant", name:"Negligible", detail: "Synonyms: imperceptible, inconsequential, slight, slim, trivial, unimportant"),
                        Word(category:"Meaning: obtain or bring about by discussion", name:"Negotiate", detail: "Synonyms: arrange, work out, thrash out, hammer out, reach an agreement on, agree on, come to terms about, reach terms on, broker"),
                        Word(category:"Meaning: settle or lie comfortably within or against something", name:"Nestle", detail: "Synonyms: snuggle, cuddle (up), curl up, huddle, nuzzle, settle, lie close, burrow; snug down"),
                        Word(category:"Meaning: worthy of attention or notice; remarkable", name:"Notable", detail: "Synonyms: noteworthy, remarkable, outstanding, important, significant, momentous, headline, memorable, unforgettable, pronounced, marked, striking, glaring"),
                        Word(category:"Meaning: the central and most important part of an object, movement, or group, forming the basis for its activity and growth", name:"Nucleus", detail: "Synonyms: core, centre, central part, most important part, heart, nub, hub, middle, midpoint, eye, kernel, focus, focal point, pivot, crux"),
                        Word(category:"Meaning: care for and protect (someone or something) while they are growing", name:"Nurture", detail: "Synonyms: bring up, care for, provide for, take care of, attend to, look after, rear, support, raise, foster, parent, mother, tend"),
                        
                        
                        
                        //O
                        
                        Word(category:"Meaning: (of a person or their judgement) not influenced by personal feelings or opinions in considering and representing facts", name:"Objective", detail: "Synonyms: impartial, unbiased, unprejudiced, non-partisan, disinterested, non-discriminatory, neutral, uninvolved, even-handed, equitable, fair, fair-minded"),
                        Word(category:"Meaning: quick to notice or perceive things", name:"Observant", detail: "Synonyms: alert, sharp-eyed, sharp, eagle-eyed, hawk-eyed, with eyes like a hawk, keen-eyed, watchful, on the lookout, on the qui vive, on guard"),
                        Word(category:"Meaning: notice or perceive (something) and register it as being significant", name:"Observe", detail: "Synonyms: notice, see, note, perceive, discern, remark, spot, detect, discover, distinguish, make out"),
                        Word(category:"Meaning: in or ready for use", name:"Operational", detail: "Synonyms: up and running, running, working, functioning, operative, in operation, in use, in action, going"),
                        Word(category:"Meaning: (of a time) especially convenient or appropriate for a particular action or event", name:"Opportune", detail: "Synonyms: auspicious, propitious, favourable, advantageous, heaven-sent, golden, good, right, lucky, happy, fortunate, benign, providential, felicitous"),
                        Word(category:"Meaning: a time or set of circumstances that makes it possible to do something", name:"Opportunity", detail: "Synonyms: chance, lucky chance, good time, golden opportunity, time, occasion, moment, favourable time/occasion/moment, right set of circumstances"),
                        Word(category:"Meaning: hopefulness and confidence about the future or the success of something", name:"Optimism", detail: "Synonyms: hopefulness, hope, confidence, buoyancy, cheer, good cheer, cheerfulness, sanguineness, positiveness, positive attitude"),
                        Word(category:"Meaning: most conducive to a favourable outcome; best", name:"Optimum", detail: "Synonyms: best, most favourable, most advantageous, most appropriate, ideal, perfect, prime, optimal, model"),
                        Word(category:"Meaning: a thing that is or may be chosen", name:"Option", detail: "Synonyms: choice, alternative, recourse, possibility, course of action"),
                        Word(category:"Meaning: neatly and methodically arranged", name:"Orderly", detail: "Synonyms: neat, tidy, well ordered, in order, trim, in apple-pie order, as neat as a new pin, spick and span, well kept, straight"),
                        Word(category:"Meaning: arrange systematically; order", name:"Organize", detail: "Synonyms: put in order, order, arrange, sort, sort out, assemble, marshal, put straight, group, dispose, classify, collocate, categorize, catalogue, codify, tabulate"),
                        Word(category:"Meaning: present or existing from the beginning; first or earliest", name:"Original", detail: "Synonyms: indigenous, native, aboriginal"),
                        Word(category:"Meaning: be superior to in action or performance", name:"Outdo", detail: "Synonyms: surpass, outshine, do better than"),
                        Word(category:"Meaning: friendly and socially confident", name:"Outgoing", detail: "Synonyms: extrovert, uninhibited, unreserved, demonstrative, affectionate, warm, friendly, genial, cordial, affable, easy-going, easy, hail-fellow-well-met"),
                        Word(category:"Meaning: a line or set of lines enclosing or indicating the shape of an object in a sketch or diagram", name:"Outline", detail: "Synonyms: silhouette, profile, figure, shape, contour, form, line, lineaments, delineation"),
                        Word(category:"Meaning: exceptionally good", name:"Outstanding", detail: "Synonyms: excellent, marvellous, magnificent, superb, fine, wonderful, superlative, exceptional, formidable, first-class, first-rate, virtuoso, skilful, masterful"),
                        Word(category:"Meaning: a general review or summary of a subject", name:"Overview", detail: "Synonyms: analysis, audit, critique, sketch, synopsis, outline"),
                        
                        
                        
                        //P
                        
                        Word(category:"Meaning: done with or employing great care and thoroughness", name:"Painstaking", detail: "Synonyms: careful, meticulous, thorough, assiduous, sedulous, attentive, diligent, industrious, laborious, hard-working, conscientious, ultra-careful, punctilious, scrupulous"),
                        Word(category:"Meaning: (of a feeling or atmosphere) so intense as to seem almost tangible", name:"Palpable", detail: "Synonyms: perceptible, perceivable, visible, noticeable, appreciable, discernible, detectable, observable, tangible, recognizable, notable, unmistakable"),
                        Word(category:"Meaning: flamboyant confidence of style or manner", name:"Panache", detail: "Synonyms: flamboyant confidence, flamboyance, confidence, self-assurance, style, stylishness, flair, elan, dash, flourish, verve, zest, spirit"),
                        Word(category:"Meaning: an unbroken view of the whole region surrounding an observer", name:"Panorama", detail: "Synonyms: view, vista, wide view, aerial view, bird's-eye view, scenic view, prospect, perspective, outlook, aspect, scene, scenery, landscape, seascape"),
                        Word(category:"Meaning: a typical example or pattern of something; a pattern or model", name:"Paradigm", detail: "Synonyms: archetype, chart, criterion, exemplar, ideal, mirror, model, original, pattern, prototype"),
                        Word(category:"Meaning: a person or thing viewed as a model of excellence", name:"Paragon", detail: "Synonyms: perfect example, shining example, good example, model, epitome, archetype, ideal, exemplar, nonpareil, paradigm, embodiment, personification"),
                        Word(category:"Meaning: a limit or boundary which defines the scope of a particular process or activity", name:"Parameter", detail: "Synonyms: framework, variable, limit, boundary, limiting factor, limitation, restriction, specification, criterion, guideline"),
                        Word(category:"Meaning: be involved; take part", name:"Participate", detail: "Synonyms: take part, engage, join, get involved, share, play a part, play a role, be a participant, partake"),
                        Word(category:"Meaning: a person who takes part in an undertaking with another or others, especially in a business or firm with shared risks and profits", name:"Partner", detail: "Synonyms: colleague, associate, co-worker, fellow worker, co-partner, collaborator, ally, comrade, companion, teammate"),
                        Word(category:"Meaning: having, showing, or caused by strong feelings or beliefs", name:"Passionate", detail: "Synonyms: intense, impassioned, ardent, fervent, zealous, vehement, fiery, heated, feverish, emotional, heartfelt, eager, excited, animated, spirited, vigorous"),
                        Word(category:"Meaning: associated with country life", name:"Pastoral", detail: "Synonyms: rural, country, countryside, countrified, outdoor, rustic, agricultural, agrarian, provincial, grassy, green, verdant"),
                        Word(category:"Meaning: a quality that evokes pity or sadness", name:"Pathos", detail: "Synonyms: poignancy, tragedy, sadness, pitifulness, piteousness, pitiableness, plaintiveness, sorrowfulness"),
                        Word(category:"Meaning: a repeated decorative design", name:"Pattern", detail: "Synonyms: design, decoration, motif, marking, ornament, ornamentation, device, figure"),
                        Word(category:"Meaning: a person who brings about peace, especially by reconciling adversaries", name:"Peacemaker", detail: "Synonyms: arbitrator, arbiter, mediator, negotiator, conciliator, go-between, middleman, intermediary, moderator, intervenor, interceder, intercessor"),
                        Word(category:"Meaning: a strong or habitual liking for something or tendency to do something", name:"Penchant", detail: "Synonyms: affection, affinity, predilection, proclivity, propensity, taste, tendency"),
                        Word(category:"Meaning: having or showing sensitive insight", name:"Perceptive", detail: "Synonyms: insightful, discerning, responsive, sensitive, observant"),
                        Word(category:"Meaning: having all the required or desirable elements, qualities, or characteristics; as good as it is possible to be", name:"Perfect", detail: "Synonyms: ideal, model, without fault, faultless, flawless, consummate, quintessential, exemplary, best, best-example, ultimate, copybook"),
                        Word(category:"Meaning: officially allow (someone) to do something", name:"Permit", detail: "Synonyms: allow, let, authorize, give someone permission/authorization/leave, sanction, grant, grant someone the right, license, empower, enable"),
                        Word(category:"Meaning: continue in a course of action even in the face of difficulty or with little or no indication of success", name:"Persevere", detail: "Synonyms: persist, continue, carry on, go on, keep on, keep going, not give up, struggle on, hammer away, be persistent, be determined, see/follow something through"),
                        Word(category:"Meaning: continue in an opinion or course of action in spite of difficulty or opposition", name:"Persist", detail: "Synonyms: persevere, continue, carry on, go on, keep at it, keep on, keep going, keep it up, not give up, be persistent, be determined, see/follow something through"),
                        Word(category:"Meaning: (of a person) having a pleasant appearance and manner", name:"Personable", detail: "Synonyms: affable, amiable, attractive, charming, easygoing, gregarious, likeable, pleasant aces"),
                        Word(category:"Meaning: the combination of characteristics or qualities that form an individual's distinctive character", name:"Personality", detail: "Synonyms: character, nature, disposition, temperament, make-up, persona, psyche, identity"),
                        Word(category:"Meaning: a view or prospect", name:"Perspective", detail: "Synonyms: view, vista, panorama, prospect, bird's-eye view, sweep, outlook, aspect"),
                        Word(category:"Meaning: induce (someone) to do something through reasoning or argument", name:"Persuade", detail: "Synonyms: prevail on, talk someone into, coax, convince, make, get, press someone into, induce, win someone over, bring someone round, argue someone into"),
                        Word(category:"Meaning: good at persuading someone to do or believe something through reasoning or the use of temptation", name:"Persuasive", detail: "Synonyms: convincing, effective, cogent, compelling, potent, forceful, eloquent, impressive, weighty, influential, sound, valid, powerful, strong, effectual, efficacious"),
                        Word(category:"Meaning: a distinct period or stage in a process of change or forming part of something's development", name:"Phase", detail: "Synonyms: stage, period, chapter, episode, part, step, point, time, juncture"),
                        Word(category:"Meaning: remarkable or exceptional, especially exceptionally good", name:"Phenomenal", detail: "Synonyms: exceptional, extraordinary, remarkable, outstanding, amazing, astonishing, astounding, stunning, staggering, marvellous, magnificent, wonderful"),
                        Word(category:"Meaning: (of a person) having an unemotional and stolidly calm disposition", name:"Phlegmatic", detail: "Synonyms: along for the ride, apathetic, blah, cold, cool, deadpan, dull"),
                        Word(category:"Meaning: (of a place or building) visually attractive, especially in a quaint or charming way", name:"Picturesque", detail: "Synonyms: attractive, pretty, beautiful, lovely, scenic, charming, quaint, pleasing, delightful, romantic"),
                        Word(category:"Meaning: a tiny dot or point", name:"Pinpoint", detail: "Synonyms: point, spot, speck, dot, fleck"),
                        Word(category:"Meaning: a person who is among the first to explore or settle a new country or area", name:"Pioneer", detail: "Synonyms: settler, colonist, colonizer, frontiersman/frontierswoman, explorer, trailblazer, discoverer"),
                        Word(category:"Meaning: of crucial importance in relation to the development or success of something else", name:"Pivotal", detail: "Synonyms: central, crucial, vital, critical, focal, essential, key, significant, important, determining, decisive, deciding"),
                        Word(category:"Meaning: a raised floor or stage used by public speakers or performers so that they can be seen by their audience", name:"Platform", detail: "Synonyms: stage, dais, stand, rostrum, podium, soapbox"),
                        Word(category:"Meaning: pleasing", name:"Pleasurable", detail: "Synonyms: enjoyable, entertaining, gratifying, pleasing, satisfying"),
                        Word(category:"Meaning: existing in or yielding great quantities; abundant", name:"Plentiful", detail: "Synonyms: abundant, copious, ample, profuse, rich, lavish, liberal, generous, bountiful, large, huge, great, bumper, flush, overflowing, superabundant, infinite"),
                        Word(category:"Meaning: a large or excessive amount of something", name:"Plethora", detail: "Synonyms: deluge, glut, plenty, profusion, surfeit, flood, much, enormous, many"),
                        Word(category:"Meaning: evoking a keen sense of sadness or regret", name:"Poignant", detail: "Synonyms: touching, moving, sad, saddening, affecting, pitiful, piteous, pitiable, pathetic, sorrowful, mournful, tearful, wretched, miserable, bitter, painful"),
                        Word(category:"Meaning: having a sharpened or tapered tip or end", name:"Pointed", detail: "Synonyms: sharp, spear-like, needle-like, spear-shaped, V-shaped, tapering, tapered, cone-shaped, conic, conical, acute, sharp-cornered"),
                        Word(category:"Meaning: shiny as a result of being rubbed", name:"Polished", detail: "Synonyms: shiny, shining, bright, glossy, gleaming, lustrous"),
                        Word(category:"Meaning: relating to the government or public affairs of a country", name:"Political", detail: "Synonyms: governmental, government, local government, ministerial, parliamentary, party political, diplomatic, legislative, policy-making, constitutional"),
                        Word(category:"Meaning: liked or admired by many people or by a particular person or group", name:"Popular", detail: "Synonyms: well liked, liked, favoured, in favour, well received, approved, admired, accepted, welcome, sought-after, in demand, desired, wanted"),
                        Word(category:"Meaning: a large, thin, flat case for loose sheets of paper such as drawings or maps", name:"Portfolio", detail: "Synonyms: bag, briefcase, case, container, envelope, folder, notebook"),
                        Word(category:"Meaning: a painting, drawing, photograph, or engraving of a person, especially one depicting only the face or head and shoulders", name:"Portrait", detail: "Synonyms: painting, picture, drawing, sketch, likeness, image, study, representation, portrayal, depiction, canvas"),
                        Word(category:"Meaning: depict (someone or something) in a work of art or literature", name:"Portray", detail: "Synonyms: paint, draw, paint/draw a picture of, picture, sketch, depict, represent, illustrate, present, show, render"),
                        Word(category:"Meaning: expressing or implying affirmation, agreement, or permission", name:"Positive", detail: "Synonyms: affirmative, favourable, approving, in the affirmative, good, constructive, enthusiastic, supportive, reassuring, encouraging"),
                        Word(category:"Meaning: having or showing the capacity to develop into something in the future", name:"Potential", detail: "Synonyms: possible, likely, prospective, future, probable, budding, in the making"),
                        Word(category:"Meaning: having great power or strength", name:"Powerful", detail: "Synonyms: strong, muscular, muscly, sturdy, strapping, robust, mighty, hefty, brawny, burly, husky, athletic, manly, well built, Herculean, tough, solid, substantial"),
                        Word(category:"Meaning: able to be done or put into practice successfully", name:"Practicable", detail: "Synonyms: achievable, applicable, attainable, doable, feasible, handy, practical, viable, workable"),
                        Word(category:"Meaning: of or concerned with the actual doing or use of something rather than with theory and ideas", name:"Practical", detail: "Synonyms: empirical, hands-on, pragmatic, real, actual, active, applied, experiential, experimental, non-theoretical, in the field"),
                        Word(category:"Meaning: dealing with things sensibly and realistically in a way that is based on practical rather than theoretical considerations", name:"Pragmatic", detail: "Synonyms: businesslike, down-to-earth, efficient, hardheaded, logical, practical, realistic, sober"),
                        Word(category:"Meaning: deserving approval and admiration", name:"Praiseworthy", detail: "Synonyms: commendable, laudable, admirable, creditable, worthy, worthy of admiration, meritorious, deserving, honourable, estimable, exemplary, excellent, sterling"),
                        Word(category:"Meaning: of great value; not to be wasted or treated carelessly", name:"Precious", detail: "Synonyms: valuable, costly, expensive, high-priced, dear"),
                        Word(category:"Meaning: marked by exactness and accuracy of expression or detail", name:"Precise", detail: "Synonyms: exact, accurate, correct, error-free, pinpoint, specific, detailed, explicit, clear-cut, unambiguous, meticulous, close, strict, definite, particular, express"),
                        Word(category:"Meaning: present as the strongest or main element", name:"Predominant", detail: "Synonyms: main, chief, principal, most important, of greatest importance, primary, prime, overriding, uppermost, central, cardinal, leading, top-tier, foremost"),
                        Word(category:"Meaning: more desirable or suitable", name:"Preferable", detail: "Synonyms: better, best, more desirable, more suitable, more advisable, advantageous, superior, preferred, recommended, favoured, nicer, more expedient"),
                        Word(category:"Meaning: a greater liking for one alternative over another or others", name:"Preference", detail: "Synonyms: liking, partiality, predilection, proclivity, fondness, taste, inclination, leaning, bias, bent, penchant, predisposition, desire, wish"),
                        Word(category:"Meaning: like (one thing or person) better than another or others; tend to choose", name:"Preferred", detail: "Synonyms: like better, would rather (have), would sooner (have), favour, be more partial to"),
                        Word(category:"Meaning: an assertion or proposition which forms the basis for a work or theory", name:"Premise", detail: "Synonyms: proposition, assumption, hypothesis, thesis, presupposition, postulation, postulate, supposition, presumption, surmise, conjecture, speculation, datum"),
                        Word(category:"Meaning: an amount to be paid for a contract of insurance", name:"Premium", detail: "Synonyms: insurance charge, insurance payment, regular payment, instalment"),
                        Word(category:"Meaning: a right or privilege exclusive to a particular individual or class", name:"Prerogative", detail: "Synonyms: entitlement, right, privilege, advantage, due, birthright"),
                        Word(category:"Meaning: the state or fact of existing, occurring, or being present", name:"Presence", detail: "Synonyms: existence, being there"),
                        Word(category:"Meaning: clean, smart, or decent enough to be seen in public", name:"Presentable", detail: "Synonyms: tidy, neat, fit to be seen, orderly, straight, clean, spick and span, in good order, shipshape (and Bristol fashion), in apple-pie order"),
                        Word(category:"Meaning: the giving of something to someone, especially as part of a formal ceremony", name:"Presentation", detail: "Synonyms: awarding, presenting, giving, handing over, dispensing, handing out, conferral, bestowal, granting, donation, award, according, extending, entrusting"),
                        Word(category:"Meaning: widespread respect and admiration felt for someone or something on the basis of a perception of their achievements or quality", name:"Prestige", detail: "Synonyms: status, standing, stature, prestigiousness, reputation, repute, regard, fame, note, renown, honour, esteem, estimation, image, account, rank, celebrity"),
                        Word(category:"Meaning: widespread in a particular area or at a particular time", name:"Prevalent", detail: "Synonyms: widespread, prevailing, frequent, usual, common, general, universal, pervasive, extensive, ubiquitous, ordinary"),
                        Word(category:"Meaning: the fact of being pre-eminent or most important", name:"Primacy", detail: "Synonyms: greater importance, priority, precedence, pre-eminence, preference, superiority, first place, pride of place, weighting, supremacy, ascendancy"),
                        Word(category:"Meaning: of chief importance; principal", name:"Primary", detail: "Synonyms: main, chief, key, prime, central, principal, foremost, first, most important, predominant, paramount, overriding, major, ruling, dominant"),
                        Word(category:"Meaning: of first importance; main", name:"Prime", detail: "Synonyms: main, chief, key, primary, central, principal, foremost, first, most important, paramount, major, dominant, supreme, overriding"),
                        Word(category:"Meaning: first in order of importance; main", name:"Principal", detail: "Synonyms: main, chief, primary, leading, foremost, first, most important, predominant, dominant, (most) prominent"),
                        Word(category:"Meaning: the fact or condition of being regarded or treated as more important than others", name:"Priority", detail: "Synonyms: prime concern, first concern, most important consideration, most pressing matter, matter of greatest importance, primary issue"),
                        Word(category:"Meaning: a special right, advantage, or immunity granted or available only to a particular person or group", name:"Privilege", detail: "Synonyms: advantage, right, benefit, prerogative, entitlement, birthright, due"),
                        Word(category:"Meaning: (of a person or action) creating or controlling a situation rather than just responding to it after it has happened", name:"Proactive", detail: "Synonyms: aggressive, anxious, ardent, banzai, can-do, dedicated, eager, excited"),
                        Word(category:"Meaning: the quality of having strong moral principles; honesty and decency", name:"Probity", detail: "Synonyms: integrity, honesty, uprightness, decency, morality, rectitude, goodness, virtue, right-mindedness, trustworthiness, truthfulness, honour, honourableness"),
                        Word(category:"Meaning: remarkably or impressively great in extent, size, or degree", name:"Prodigious", detail: "Synonyms: enormous, huge, colossal, immense, vast, great, massive, gigantic, mammoth, tremendous, considerable, substantial, large"),
                        Word(category:"Meaning: a young person with exceptional qualities or abilities", name:"Prodigy", detail: "Synonyms: child genius, genius, wonder child, mastermind, virtuoso"),
                        Word(category:"Meaning: producing or able to produce large amounts of goods, crops, or other commodities", name:"Productive", detail: "Synonyms: fertile, fruitful, rich, fecund, high-yielding"),
                        Word(category:"Meaning: relating to or belonging to a profession", name:"Professional", detail: "Synonyms: white-collar, executive, non-manual"),
                        Word(category:"Meaning: competent or skilled in doing or using something", name:"Proficient", detail: "Synonyms: skilled, skilful, expert, accomplished, experienced, practised, trained, seasoned, well versed, adept, adroit, deft, dexterous, able, capable, competent"),
                        Word(category:"Meaning: an outline of something, especially a person's face, as seen from one side", name:"Profile", detail: "Synonyms: side view, outline, silhouette, contour, shape, form, figure, lines"),
                        Word(category:"Meaning: (of a business or activity) yielding profit or financial gain", name:"Profitable", detail: "Synonyms: moneymaking, profit-making, commercial, successful, commercially successful, money-spinning, sound, solvent, in the black, cost-effective"),
                        Word(category:"Meaning: (of a state, quality, or emotion) very great or intense", name:"Profound", detail: "Synonyms: heartfelt, intense, keen, great, very great, extreme, sincere, earnest, deep, deepest, deeply felt, wholehearted, acute, overpowering, overwhelming"),
                        Word(category:"Meaning: a planned series of future events or performances", name:"Programme", detail: "Synonyms: schedule, agenda, calendar, timetable"),
                        Word(category:"Meaning: forward or onward movement towards a destination", name:"Progress", detail: "Synonyms: forward movement, onward movement, progression, advance, advancement, headway, passage; going"),
                        Word(category:"Meaning: an individual or collaborative enterprise that is carefully planned to achieve a particular aim", name:"Project", detail: "Synonyms: assignment, piece of work, homework, piece of research, task"),
                        Word(category:"Meaning: (of a plant, animal, or person) producing much fruit or foliage or many offspring", name:"Prolific", detail: "Synonyms: productive, creative, inventive, fertile"),
                        Word(category:"Meaning: important; famous", name:"Prominent", detail: "Synonyms: important, well known, leading, eminent, pre-eminent, distinguished, notable, noteworthy, noted, public, outstanding, foremost, of mark"),
                        Word(category:"Meaning: a declaration or assurance that one will do something or that a particular thing will happen", name:"Promise", detail: "Synonyms: word of honour, word, assurance, pledge, vow, guarantee, oath, bond, undertaking, agreement, commitment, contract, covenant, compact"),
                        Word(category:"Meaning: support or actively encourage (a cause, venture, etc.); further the progress of", name:"Promote", detail: "Synonyms: encourage, further, advance, assist, aid, help, contribute to, foster, nurture, develop, boost, stimulate, forward"),
                        Word(category:"Meaning: (of an event or fact) cause or bring about (an action or feeling)", name:"Prompt", detail: "Synonyms: give rise to, bring about, cause, occasion, result in, lead to, elicit, produce, bring on, engender, induce, call forth, evoke, precipitate, trigger"),
                        Word(category:"Meaning: an inclination or natural tendency to behave in a particular way", name:"Propensity", detail: "Synonyms: tendency, inclination, predisposition, proneness, proclivity, readiness, susceptibility, liability, disposition"),
                        Word(category:"Meaning: put forward (a plan or suggestion) for consideration by others", name:"Propose", detail: "Synonyms: put forward, suggest, advance, offer, present, move, submit, prefer, file, lodge, table, initiate, bring, bring forward, come up with, tender, bid, project"),
                        Word(category:"Meaning: a statement or assertion that expresses a judgement or opinion", name:"Proposition", detail: "Synonyms: theory, hypothesis, thesis, argument, premise, postulation, theorem, concept, idea, statement"),
                        Word(category:"Meaning: the possibility or likelihood of some future event occurring", name:"Prospect", detail: "Synonyms: likelihood, hope, expectation, anticipation, (good/poor) chance, chances, odds, probability, possibility, likeliness, promise, lookout"),
                        Word(category:"Meaning: likely to happen at a future date", name:"Prospective", detail: "Synonyms: potential, possible, probable, likely, future, eventual, -to-be, soon-to-be, in the making, destined, intended"),
                        Word(category:"Meaning: flourish physically; grow strong and healthy", name:"Prosper", detail: "Synonyms: do well, get on well, go well, fare well"),
                        Word(category:"Meaning: make available for use; supply", name:"Provide", detail: "Synonyms: supply, give, issue, furnish, lay out, come up with, dispense, bestow, impart, produce, yield, bring forth, bear, deliver, donate, contribute, pledge"),
                        Word(category:"Meaning: the action of providing or supplying something for use", name:"Provision", detail: "Synonyms: supplying, supply, providing, purveying, delivery, furnishing, equipping, giving, donation, allocation, distribution, presentation"),
                        Word(category:"Meaning: stimulate or give rise to (a reaction or emotion, typically a strong or unwelcome one) in someone", name:"Provoke", detail: "Synonyms: arouse, produce, evoke, cause, give rise to, occasion, call forth, draw forth, elicit, induce, inspire, excite, spark off, touch off, kindle, generate, engender, instigate"),
                        Word(category:"Meaning: acting with or showing care and thought for the future", name:"Prudent", detail: "Synonyms: wise, well judged, judicious, sagacious, sage, shrewd, advisable, well advised, politic, sensible, commonsensical"),
                        Word(category:"Meaning: not mixed or adulterated with any other substance or material", name:"Pure", detail: "Synonyms: unmixed, unalloyed, unadulterated, unblended, uncontaminated, sterling, solid, refined"),
                        Word(category:"Meaning: the reason for which something is done or created or for which something exists", name:"Purpose", detail: "Synonyms: motive, motivation, grounds, cause, impetus, occasion, reason, point, basis, justification"),
                        
                        
                        
                        //Q
                        
                        Word(category:"Meaning: be entitled to a particular benefit or privilege by fulfilling a necessary condition", name:"Qualify", detail: "Synonyms: be eligible, meet the requirements"),
                        Word(category:"Meaning: the standard of something as measured against other things of a similar kind; the degree of excellence of something", name:"Quality", detail: "Synonyms: standard, grade, class, classification, calibre, status, condition, character, nature, constitution, make-up, form, rank, worth, value, level"),
                        Word(category:"Meaning: express or measure the quantity o", name:"Quantify", detail: "Synonyms: appraise, assess, calibrate, compute, evaluate, gauge, specify, check"),
                        Word(category:"Meaning: representing the most perfect or typical example of a quality or class", name:"Quintessential", detail: "Synonyms: typical, prototypical, stereotypical, archetypal, classic, model, essential, standard, stock, representative, true to type, conventional"),
                        
                        
                        
                        //R
                        
                        Word(category:"Meaning: (especially of change or action) relating to or affecting the fundamental nature of something; far-reaching or thorough", name:"Radical", detail: "Synonyms: thoroughgoing, thorough, complete, total, entire, absolute, utter, comprehensive, exhaustive, root-and-branch, sweeping, far-reaching, wide-ranging"),
                        Word(category:"Meaning: a complex or unwelcome consequence of an action or event", name:"Ramification", detail: "Synonyms: consequence, result, aftermath, outcome, effect, upshot, issue, sequel"),
                        Word(category:"Meaning: the area of variation between upper and lower limits on a particular scale", name:"Range", detail: "Synonyms: span, scope, compass, radius, scale, gamut, reach, sweep, extent, area, field, orbit, ambit, province, realm, domain, horizon, latitude"),
                        Word(category:"Meaning: happening in a short time or at a great rate", name:"Rapid", detail: "Synonyms: quick, fast, swift, speedy, high-speed, expeditious, express, brisk, lively, prompt, flying, fleeting, lightning, meteoric, overnight, whirlwind, fast-track"),
                        Word(category:"Meaning: a close and harmonious relationship in which the people or groups concerned understand each other's feelings or ideas and communicate well", name:"Rapport", detail: "Synonyms: affinity, close/special relationship, (mutual) understanding, bond, empathy, harmony, sympathy, link, accord"),
                        Word(category:"Meaning: based on or in accordance with reason or logic", name:"Rational", detail: "Synonyms: logical, reasoned, well reasoned, sensible, reasonable, cogent, coherent, intelligent, wise, judicious, sagacious, astute, shrewd, perceptive, enlightened"),
                        Word(category:"Meaning: the attitude or practice of accepting a situation as it is and being prepared to deal with it accordingly", name:"Realism", detail: "Synonyms: pragmatism, practicality, matter-of-factness, common sense, level-headedness, clear-sightedness"),
                        Word(category:"Meaning: the state of things as they actually exist, as opposed to an idealistic or notional idea of them", name:"Reality", detail: "Synonyms: the real world, real life, actuality"),
                        Word(category:"Meaning: become fully aware of (something) as a fact; understand clearly", name:"Realize", detail: "Synonyms: register, perceive, discern, be/become aware of (the fact that), be/become conscious of (the fact that), notice"),
                        Word(category:"Meaning: a kingdom", name:"Realm", detail: "Synonyms: kingdom, sovereign state, monarchy"),
                        Word(category:"Meaning: a cause, explanation, or justification for an action or event", name:"Reason", detail: "Synonyms: cause, grounds, ground, basis, rationale"),
                        Word(category:"Meaning: having sound judgement; fair and sensible", name:"Reasonable", detail: "Synonyms: sensible, rational, open to reason, full of common sense, logical, fair, fair-minded, just, equitable, decent"),
                        Word(category:"Meaning: willing to consider or accept new suggestions and ideas", name:"Receptive", detail: "Synonyms: open-minded, ready/willing to consider new ideas, open to new ideas, open to suggestions, open, responsive, amenable, sympathetic, well disposed"),
                        Word(category:"Meaning: identify from knowledge of appearance or character", name:"Recognize", detail: "Synonyms: identify, place, know, know again, pick out, put a name to"),
                        Word(category:"Meaning: put forward (someone or something) with approval as being suitable for a particular purpose or role", name:"Recommend", detail: "Synonyms: advocate, endorse, commend, approve, suggest, put forward, propose, advance, nominate, put up, mention"),
                        Word(category:"Meaning: enlist (someone) in the armed forces", name:"Recruit", detail: "Synonyms: enlist, sign up, enrol, engage, take on, round up"),
                        Word(category:"Meaning: remove impurities or unwanted elements from (a substance), typically as part of an industrial process", name:"Refine", detail: "Synonyms: purify, clarify, clear, cleanse, strain, sift, filter, rarefy, distil, concentrate, process, treat"),
                        Word(category:"Meaning: serving to refresh or reinvigorate someone", name:"Refreshing", detail: "Synonyms: invigorating, revitalizing, reviving, restoring, bracing, fortifying, enlivening, stimulating, freshening, energizing, exhilarating, reanimating, revivifying, rejuvenating"),
                        Word(category:"Meaning: strengthen or support (an object or substance), especially with additional material", name:"Reinforce", detail: "Synonyms: strengthen, fortify, bolster up, shore up, buttress, prop up, underpin, brace, stiffen, toughen, support, hold up"),
                        Word(category:"Meaning: make or show a connection between", name:"Relate", detail: "Synonyms: connect (with), associate (with), link (with), correlate (with), ally (with), couple (with), bracket (with)"),
                        Word(category:"Meaning: considered in relation or in proportion to something else", name:"Relative", detail: "Synonyms: comparative, respective, comparable, correlative, parallel, corresponding, reciprocal"),
                        Word(category:"Meaning: free from tension and anxiety", name:"Relaxed", detail: "Synonyms: breezy, calm, carefree, casual, easy, informal, placid, serene, tolerant"),
                        Word(category:"Meaning: closely connected or appropriate to what is being done or considered", name:"Relevant", detail: "Synonyms: pertinent, applicable, apposite, material, apropos, to the point, to the purpose, germane, admissible"),
                        Word(category:"Meaning: consistently good in quality or performance; able to be trusted", name:"Reliable", detail: "Synonyms: dependable, good, well founded, well grounded, authentic, definitive, attested, valid, genuine, from the horse's mouth, sound, true"),
                        Word(category:"Meaning: liking for or pleasurable anticipation of something", name:"Relish", detail: "Synonyms: enjoyment, gusto, delight, pleasure, glee, rapture, satisfaction, contentment, contentedness, gratification, happiness, exhilaration, excitement, titillation"),
                        Word(category:"Meaning: worthy of attention; striking", name:"Remarkable", detail: "Synonyms: extraordinary, exceptional, amazing, astonishing, astounding, marvellous, wonderful, sensational, stunning, incredible, unbelievable, miraculous, phenomenal"),
                        Word(category:"Meaning: the revival of European art and literature under the influence of classical models in the 14th–16th centuries", name:"Renaissance", detail: "Synonyms: rejuvenation, renewal, resurgence, revitalisation, revival, awakening, new dawn"),
                        Word(category:"Meaning: known or talked about by many people; famous", name:"Renowned", detail: "Synonyms: famous, celebrated, famed, eminent, distinguished, acclaimed, illustrious, pre-eminent, prominent, great, esteemed, well thought of"),
                        Word(category:"Meaning: depict (a particular subject) in a work of art", name:"Represent", detail: "Synonyms: depict, portray, render, picture, delineate, show, illustrate, characterize, paint, draw, sketch"),
                        Word(category:"Meaning: typical of a class, group, or body of opinion", name:"Representative", detail: "Synonyms: typical, prototypical, characteristic, illustrative, indicative"),
                        Word(category:"Meaning: having a good reputation", name:"Reputable", detail: "Synonyms: well thought of, highly regarded, well respected, respected, respectable, with a good reputation, of repute, of good repute, creditable, esteemed"),
                        Word(category:"Meaning: a widespread belief that someone or something has a particular characteristic", name:"Reputation", detail: "Synonyms: name, good name, character, repute, standing, stature, status, position, rank, station"),
                        Word(category:"Meaning: the ability of a substance or object to spring back into shape; elasticity", name:"Resilience", detail: "Synonyms: flexibility, pliability, suppleness, plasticity, elasticity, springiness, spring, give"),
                        Word(category:"Meaning: admirably purposeful, determined, and unwavering", name:"Resolute", detail: "Synonyms: determined, purposeful, purposive, resolved, decided, adamant, single-minded, firm, unswerving, unwavering, undaunted, fixed, set, intent, insistent"),
                        Word(category:"Meaning: settle or find a solution to (a problem or contentious matter)", name:"Resolve", detail: "Synonyms: settle, sort out, solve, find a solution to, find an answer to, fix, work out, straighten out, deal with, put right, set right, put to rights, rectify"),
                        Word(category:"Meaning: the quality in a sound of being deep, full, and reverberating", name:"Resonance", detail: "Synonyms: fullness, plangency, sonority, vibration"),
                        Word(category:"Meaning: produce or be filled with a deep, full, reverberating sound", name:"Resonate", detail: "Synonyms: echo, reverberate, vibrate, oscillate, reproduce, ring, sound"),
                        Word(category:"Meaning: a stock or supply of money, materials, staff, and other assets that can be drawn on by a person or organization in order to function effectively", name:"Resource", detail: "Synonyms: assets, funds, wealth, money, riches, capital, deep pockets"),
                        Word(category:"Meaning: having the ability to find quick and clever ways to overcome difficulties", name:"Resourceful", detail: "Synonyms: ingenious, imaginative, inventive, creative"),
                        Word(category:"Meaning: attractive and impressive through being richly colourful or sumptuous", name:"Resplendent", detail: "Synonyms: splendid, magnificent, brilliant, dazzling, glittering, glowing, radiant, gorgeous, transcendent, impressive, imposing, spectacular, striking"),
                        Word(category:"Meaning: having an obligation to do something, or having control over or care for someone, as part of one's job or role", name:"Responsible", detail: "Synonyms: in charge of, in control of, at the helm of, accountable for, liable for, charged with"),
                        Word(category:"Meaning: reacting quickly and positively", name:"Responsive", detail: "Synonyms: quick to react, reactive, receptive, open to suggestions, amenable, flexible, accessible, approachable, forthcoming, sensitive, perceptive, sympathetic"),
                        Word(category:"Meaning: characterized by reserve or moderation; unemotional or dispassionate", name:"Restrained", detail: "Synonyms: self-controlled, controlled, self-restrained, moderate, not given to excesses, sober, steady, phlegmatic, unemotional, inhibited, undemonstrative, unassuming"),
                        Word(category:"Meaning: continue to have (something); keep possession of", name:"Retain", detail: "Synonyms: keep, keep possession of, keep hold of, hold on to, hold fast to, keep back, hang on to, cling to"),
                        Word(category:"Meaning: continue to have (something); keep possession of", name:"Reveal", detail: "Synonyms: keep, keep possession of, keep hold of, hold on to, hold fast to, keep back, hang on to, cling to"),
                        Word(category:"Meaning: enjoy oneself in a lively and noisy way, especially with drinking and dancing", name:"Revel", detail: "Synonyms: celebrate, make merry, have a party, party, feast, eat, drink, and be merry, carouse, roister, have fun, have a good time, enjoy oneself, go on a spree"),
                        Word(category:"Meaning: a formal assessment of something with the intention of instituting change if necessary", name:"Review", detail: "Synonyms: analysis, evaluation, assessment, appraisal, examination, investigation, scrutiny, enquiry, exploration, probe, inspection, study, audit"),
                        Word(category:"Meaning: come back to or visit again", name:"Revisit", detail: "Synonyms: call, frequent, return, stay, visit often"),
                        Word(category:"Meaning: imbue (something) with new life and vitality", name:"Revitalize", detail: "Synonyms: reinvigorate, re-energize, brace, fortify, strengthen, give new strength to, give a boost to, build up, bolster, prop up, help, renew, regenerate, restore, revive"),
                        Word(category:"Meaning: restore to life or consciousness", name:"Revive", detail: "Synonyms: resuscitate, bring round, bring to life, bring back, bring someone (back) to their senses, bring back to consciousness, bring back from the edge of death"),
                        Word(category:"Meaning: involving or causing a complete or dramatic change", name:"Revolutionary", detail: "Synonyms: thoroughgoing, thorough, complete, total, entire, absolute, utter, comprehensive, exhaustive, sweeping, far-reaching, wide-ranging, extensive, profound"),
                        Word(category:"Meaning: a thing given in recognition of service, effort, or achievement", name:"Reward", detail: "Synonyms: recompense, prize, prize money, winnings, purse, award, honour, decoration, profit, advantage, benefit, bonus, plus, premium"),
                        Word(category:"Meaning: having a legitimate right to property, position, or status", name:"Rightful", detail: "Synonyms: legal, lawful, licit, sanctioned"),
                        Word(category:"Meaning: extremely thorough and careful", name:"Rigorous", detail: "Synonyms: meticulous, punctilious, conscientious, careful, diligent, attentive, ultra-careful, scrupulous, painstaking, exact, precise, accurate, correct, thorough"),
                        Word(category:"Meaning: strong and healthy; vigorous", name:"Robust", detail: "Synonyms: strong, vigorous, sturdy, tough, powerful, powerfully built, solidly built, as strong as a horse/ox, muscular, sinewy, rugged, hardy, strapping, brawny, burly"),
                        Word(category:"Meaning: an actor's part in a play, film, etc", name:"Role", detail: "Synonyms: part, character"),
                        Word(category:"Meaning: relating to or denoting the group of Indo-European languages descended from Latin, principally French, Spanish, Portuguese, Italian, Catalan, Occitan, and Romanian", name:"Romance", detail: "Synonyms: affair, amour, attachment, courtship, enchantment, fascination, fling, love"),
                        
                        
                        
                        //S
                        
                        Word(category:"Meaning: a measure taken to protect someone or something or to prevent something undesirable", name:"Safeguard", detail: "Synonyms: protection, defence, guard, shelter, screen, buffer, preventive, precaution, prophylactic, provision, security, safety measure, surety, cover"),
                        Word(category:"Meaning: most noticeable or important", name:"Salient", detail: "Synonyms: important, main, principal, major, chief, primary, notable, noteworthy, outstanding, arresting, conspicuous, striking, noticeable, obvious, remarkable"),
                        Word(category:"Meaning: a small part or quantity intended to show what the whole is like", name:"Sample", detail: "Synonyms: representative, illustrative, selected, specimen, test, trial, typifying, typical"),
                        Word(category:"Meaning: refuge or safety from pursuit, persecution, or other danger", name:"Sanctuary", detail: "Synonyms: refuge, haven, harbour, port in a storm, oasis, shelter, retreat, bolt-hole, foxhole, hideout, hiding place, hideaway, den, asylum, safe house, fastness"),
                        Word(category:"Meaning: optimistic or positive, especially in an apparently bad or difficult situation", name:"Sanguine", detail: "Synonyms: optimistic, bullish, hopeful, buoyant, positive, disposed to look on the bright side, confident, cheerful, cheery, bright, assured"),
                        Word(category:"Meaning: meet the expectations, needs, or desires of (someone)", name:"Satisfy", detail: "Synonyms: please, content, make happy"),
                        Word(category:"Meaning: enjoy or appreciate (something pleasant) to the full, especially by lingering over it", name:"Savour", detail: "Synonyms: relish, enjoy, enjoy to the full, taste to the full, appreciate, delight in, take pleasure in, revel in, smack one's lips over, luxuriate in"),
                        Word(category:"Meaning: the place where an incident in real life or fiction occurs or occurred", name:"Scene", detail: "Synonyms: location, site, place, position, point, spot"),
                        Word(category:"Meaning: a distinctive smell, especially one that is pleasant", name:"Scent", detail: "Synonyms: smell, fragrance, aroma, perfume, redolence, savour, odour, whiff"),
                        Word(category:"Meaning: the extent of the area or subject matter that something deals with or to which it is relevant", name:"Scope", detail: "Synonyms: extent, range, breadth, width, reach, sweep, purview, span, stretch, spread, horizon"),
                        Word(category:"Meaning: (of a person or process) careful, thorough, and extremely attentive to details", name:"Scrupulous", detail: "Synonyms: careful, meticulous, painstaking, thorough, assiduous, sedulous, attentive, diligent, conscientious, ultra-careful, punctilious, searching, close"),
                        Word(category:"Meaning: examine or inspect closely and thoroughly", name:"Scrutinize", detail: "Synonyms: examine carefully, inspect, survey, scan, study, look over, peruse"),
                        Word(category:"Meaning: (of a fabric or surface) smooth and without seams or obvious joins", name:"Seamless", detail: "Synonyms: logical, smooth, coherent, consistent, ordered, absolute, flawless, ideal"),
                        Word(category:"Meaning: (of a place) not seen or visited by many people; sheltered and private", name:"Secluded", detail: "Synonyms: sheltered, private, concealed, hidden, undisturbed, unfrequented, sequestered, tucked away"),
                        Word(category:"Meaning: not known or seen or not meant to be known or seen by others", name:"Secret", detail: "Synonyms: confidential, strictly confidential, top secret, classified, restricted, unrevealed, undisclosed, unpublished, untold, unknown, uncommunicated"),
                        Word(category:"Meaning: fixed or fastened so as not to give way, become loose, or be lost", name:"Secure", detail: "Synonyms: tight, firm, taut, fixed, secured, done up"),
                        Word(category:"Meaning: carefully choose as being the best or most suitable", name:"Select", detail: "Synonyms: choose, pick, hand-pick, single out, pick out, sort out, take, opt for, decide on, settle on, set, fix, fix on, adopt, determine, designate, name"),
                        Word(category:"Meaning: concerned more with the needs and wishes of others than with one's own; unselfish", name:"Selfless", detail: "Synonyms: unselfish, altruistic, self-sacrificing, self-denying"),
                        Word(category:"Meaning: strongly influencing later developments", name:"Seminal", detail: "Synonyms: influential, formative, groundbreaking, pioneering, original, creative, innovative"),
                        Word(category:"Meaning: causing great public interest and excitement", name:"Sensational", detail: "Synonyms: amazing, startling, astonishing, staggering, shocking, appalling, horrifying, scandalous"),
                        Word(category:"Meaning: quick to detect or respond to slight changes, signals, or influences", name:"Sensitive", detail: "Synonyms: responsive to, quick to respond to, sensitized to, reactive to, sentient of"),
                        Word(category:"Meaning: a view or opinion that is held or expressed", name:"Sentiment", detail: "Synonyms: view, point of view, way of thinking, feeling, attitude, thought, opinion, belief, idea"),
                        Word(category:"Meaning: the occurrence and development of events by chance in a happy or beneficial way", name:"Serendipity", detail: "Synonyms: chance, happy chance, accident, happy accident, fluke"),
                        Word(category:"Meaning: calm, peaceful, and untroubled", name:"Serene", detail: "Synonyms: calm, composed, collected, cool, calm, and collected, as cool as a cucumber, tranquil, peaceful, at peace, pacific, untroubled, relaxed, at ease, poised"),
                        Word(category:"Meaning: demanding or characterized by careful consideration or application", name:"Serious", detail: "Synonyms: important, significant, consequential, of consequence, momentous, of moment, key, grave, weighty, far-reaching, major"),
                        Word(category:"Meaning: a part or portion of a larger amount which is divided among a number of people, or to which a number of people contribute", name:"Share", detail: "Synonyms: portion, part, division, bit, quota, allowance, ration, allocation, allotment, lot, measure, due"),
                        Word(category:"Meaning: a glass case used for displaying articles in a shop or museum", name:"Showcase", detail: "Synonyms: effort, examination, experiment, investigation, probation, struggle, testing, analysis, assay, attempt, audition"),
                        Word(category:"Meaning: having or showing sharp powers of judgement; astute", name:"Shrewd", detail: "Synonyms: astute, sharp-witted, sharp, acute, intelligent, clever, alert, canny, media-savvy, perceptive, perspicacious, observant, discriminating, sagacious, sage, wise, far-seeing, far-sighted"),
                        Word(category:"Meaning: sufficiently great or important to be worthy of attention; noteworthy", name:"Significant", detail: "Synonyms: notable, noteworthy, worthy of attention, remarkable, outstanding, important, of importance, of consequence, consequential"),
                        Word(category:"Meaning: the dark shape and outline of someone or something visible in restricted light against a brighter background", name:"Silhouette", detail: "Synonyms: outline, contour(s), profile, delineation, form, shape, figure, shadow, features, lines, curves, configuration"),
                        Word(category:"Meaning: imitate the appearance or character of", name:"Simulate", detail: "Synonyms: imitate, reproduce, replicate, duplicate, mimic, parallel, be a mock-up of"),
                        Word(category:"Meaning: free from pretence or deceit; proceeding from genuine feelings", name:"Sincere", detail: "Synonyms: heartfelt, wholehearted, profound, deep, from the heart"),
                        Word(category:"Meaning: the ability to do something well; expertise", name:"Skill", detail: "Synonyms: expertise, skilfulness, expertness, adeptness, adroitness, deftness, dexterity, ability, prowess, mastery, competence, competency, capability, efficiency"),
                        Word(category:"Meaning: (of hair, fur, or skin) smooth and glossy", name:"Sleek", detail: "Synonyms: smooth, glossy, shiny, shining, gleaming, lustrous, silken, silky, satiny, velvety, sheeny"),
                        Word(category:"Meaning: (of a person) clean, tidy, and well dressed", name:"Smart", detail: "Synonyms: well dressed, well turned out, fashionably dressed, fashionable, stylish, chic, modish, elegant, neat, besuited, spruce, trim, dapper, debonair"),
                        Word(category:"Meaning: having an even and regular surface; free from perceptible projections, lumps, or indentations", name:"Smooth", detail: "Synonyms: even, level, flat, as flat as a pancake, plane, flush, unwrinkled, featureless"),
                        Word(category:"Meaning: comfortable, warm, and cosy; well protected from the weather or cold", name:"Snug", detail: "Synonyms: cosy, comfortable, warm, homely, cheerful, welcoming, friendly, congenial, hospitable, relaxed, restful, reassuring, intimate, sheltered, secure"),
                        Word(category:"Meaning: willing to talk and engage in activities with other people; friendly", name:"Sociable", detail: "Synonyms: friendly, affable, amicable, cordial, neighbourly, hospitable, companionable, gregarious, convivial, clubbable"),
                        Word(category:"Meaning: the aggregate of people living together in a more or less ordered community", name:"Society", detail: "Synonyms: the community, the public, the general public, the people, the population"),
                        Word(category:"Meaning: unity or agreement of feeling or action, especially among individuals with a common interest; mutual support within a group", name:"Solidarity", detail: "Synonyms: unanimity, unity, like-mindedness, agreement, accord, harmony, consensus, concord, concurrence, singleness of purpose, community of interest, mutual support"),
                        Word(category:"Meaning: find an answer to, explanation for, or means of effectively dealing with (a problem or mystery)", name:"Solve", detail: "Synonyms: find an/the answer to, find a/the solution to, answer, resolve, work out, puzzle out, fathom, find the key to, decipher, decode, break, clear up, interpret"),
                        Word(category:"Meaning: gently calm (a person or their feelings)", name:"Soothe", detail: "Synonyms: calm, calm down, quiet, pacify, subdue, settle, settle down, comfort, hush, lull, tranquillize, appease, win over, conciliate, make peace with"),
                        Word(category:"Meaning: having, revealing, or involving a great deal of worldly experience and knowledge of fashion and culture", name:"Sophisticated", detail: "Synonyms: worldly, worldly-wise, experienced, enlightened, cosmopolitan, knowledgeable"),
                        Word(category:"Meaning: the spiritual or immaterial part of a human being or animal, regarded as immortal", name:"Soul", detail: "Synonyms: spirit, psyche, (inner) self, innermost self, (inner) ego, inner being, true being, essential nature, animating principle, life force, vital force"),
                        Word(category:"Meaning: vibrations that travel through the air or another medium and can be heard when they reach a person's or animal's ear", name:"Sound", detail: "Synonyms: noise, note, din, racket, row, bang, report, hubbub, resonance, reverberation"),
                        Word(category:"Meaning: a place, person, or thing from which something originates or can be obtained", name:"Source", detail: "Synonyms: origin, place of origin"),
                        Word(category:"Meaning: better, greater, or otherwise different from what is usual", name:"Special", detail: "Synonyms: exceptional, particular, extra special, unusual, marked, singular, uncommon, notable, noteworthy, remarkable, outstanding, unique"),
                        Word(category:"Meaning: a pursuit, area of study, or skill to which someone has devoted much time and effort and in which they are expert", name:"Speciality", detail: "Synonyms: forte, strong point, strength, métier, long suit, strong suit, talent, skill, bent, gift, claim to fame, department, pièce de résistance"),
                        Word(category:"Meaning: clearly defined or identified", name:"Specific", detail: "Synonyms: particular, specified, certain, fixed, set, determined, distinct, separate, definite, single, individual, peculiar, discrete, express, precise"),
                        Word(category:"Meaning: identify clearly and definitely", name:"Specify", detail: "Synonyms: state, name, identify, define, describe, set out, set down, draw up, frame, itemize, designate, detail, list, spell out, enumerate, particularize, catalogue"),
                        Word(category:"Meaning: beautiful in a dramatic and eye-catching way", name:"Spectacular", detail: "Synonyms: striking, picturesque, eye-catching, breathtaking, arresting, amazing, glorious"),
                        Word(category:"Meaning: a band of colours, as seen in a rainbow, produced by separation of the components of light by their different degrees of refraction according to wavelength", name:"Spectrum", detail: "Synonyms: range, gamut, sweep, scope, span"),
                        Word(category:"Meaning: holding one's attention completely as though by magic", name:"Spellbinding", detail: "Synonyms: beguile, mesmerize, allure, attract, bewitch, draw, enamour, kill, hypnotize, vamp, tickle, voodoo"),
                        Word(category:"Meaning: a round solid figure, or its surface, with every point on its surface equidistant from its centre", name:"Sphere", detail: "Synonyms: globe, ball, orb, spheroid, globule, round"),
                        Word(category:"Meaning: the non-physical part of a person which is the seat of emotions and character; the soul", name:"Spirit", detail: "Synonyms: soul, psyche, inner self, inner being, essential being"),
                        Word(category:"Meaning: magnificent; very impressive", name:"Splendid", detail: "Synonyms: magnificent, sumptuous, grand, impressive, imposing, superb, spectacular, resplendent, opulent, luxurious, palatial, deluxe, rich, fine, costly"),
                        Word(category:"Meaning: make or become unlikely to give way or overturn", name:"Stabilize", detail: "Synonyms: balance, fix, maintain, preserve, secure, steady, sustain, ballast, bolt, brace, buttress"),
                        Word(category:"Meaning: (of an object or structure) not likely to give way or overturn; firmly fixed", name:"Stable", detail: "Synonyms: firm, solid, steady, secure, fixed, strong, fast, stout, sturdy, safe, moored, anchored, stuck down, immovable, well built, well constructed, substantial"),
                        Word(category:"Meaning: a point, period, or step in a process or development", name:"Stage", detail: "Synonyms: phase, period, juncture, step, point, time, moment, instant, division, level"),
                        Word(category:"Meaning: (in gambling) an independent party with whom each of those who make a wager deposits the money or counters wagered", name:"Stakeholder", detail: "Synonyms: collaborator, colleague, partner, shareholder, associate, ally"),
                        Word(category:"Meaning: the ability to sustain prolonged physical or mental effort", name:"Stamina", detail: "Synonyms: endurance, staying power, indefatigability, tirelessness, resistance, resilience, fortitude, strength, vigour, energy, staunchness, steadfastness, robustness"),
                        Word(category:"Meaning: a level of quality or attainment", name:"Standard", detail: "Synonyms: quality, level, grade, degree, worth, calibre, merit, excellence"),
                        Word(category:"Meaning: the particular condition that someone or something is in at a specific time", name:"State", detail: "Synonyms: condition, shape, situation, circumstances, state of affairs, position"),
                        Word(category:"Meaning: a person's natural height", name:"Stature", detail: "Synonyms: height, tallness, loftiness"),
                        Word(category:"Meaning: relative social or professional position; standing", name:"Status", detail: "Synonyms: standing, rank, ranking, position, social position, station, level, footing, place"),
                        Word(category:"Meaning: required, permitted, or enacted by statute", name:"Statutory", detail: "Synonyms: lawful, legal, judicial, rightful"),
                        Word(category:"Meaning: resolutely or dutifully firm and unwavering", name:"Steadfast", detail: "Synonyms: loyal, faithful, committed, devoted, dedicated, dependable, reliable, steady, true, constant, staunch, trusty"),
                        Word(category:"Meaning: firmly fixed, supported, or balanced; not shaking or moving", name:"Steady", detail: "Synonyms: stable, balanced, firm, fixed, secure, secured, fast, safe, immovable, unshakeable, dependable"),
                        Word(category:"Meaning: relating to a star or stars", name:"Stellar", detail: "Synonyms: astronomical, cosmic, galactic, astrological, heavenly"),
                        Word(category:"Meaning: raise levels of physiological or nervous activity in (the body or any biological system)", name:"Stimulate", detail: "Synonyms: restorative, tonic, invigorating, bracing, energizing, restoring, reviving, refreshing, vitalizing, revitalizing, vivifying, revivifying"),
                        Word(category:"Meaning: a thing or event that evokes a specific functional reaction in an organ or tissue", name:"Stimulus", detail: "Synonyms: spur, stimulant, encouragement, impetus, boost, prompt, prod, incentive, inducement, inspiration, fillip"),
                        Word(category:"Meaning: causing excitement or strong emotion; rousing", name:"Stirring", detail: "Synonyms: exciting, thrilling, action-packed, gripping, riveting, dramatic, rousing, spirited, stimulating, moving, inspiring, inspirational, electrifying"),
                        Word(category:"Meaning: enduring pain and hardship without showing one's feelings or complaining", name:"Stoical", detail: "Synonyms: long-suffering, uncomplaining, patient, forbearing, accepting, stoic, with the patience of Job, resigned, impassive, unemotional, phlegmatic, philosophical"),
                        Word(category:"Meaning: uncomplicated and easy to do or understand", name:"Straightforward", detail: "Synonyms: uncomplicated, simple, easy, effortless, painless, undemanding, unexacting"),
                        Word(category:"Meaning: the shore of a sea, lake, or large river", name:"Strand", detail: "Synonyms: seashore, shore, beach, sands, foreshore, shoreline"),
                        Word(category:"Meaning: a plan of action designed to achieve a long-term or overall aim", name:"Strategy", detail: "Synonyms: master plan, grand design, game plan, plan of action, plan, policy, proposed action, scheme, blueprint, programme, procedure, approach, schedule"),
                        Word(category:"Meaning: the quality or state of being physically strong", name:"Strength", detail: "Synonyms: power, brawn, brawniness, muscle, muscularity, burliness, sturdiness, robustness, toughness, hardiness, lustiness"),
                        Word(category:"Meaning: attracting attention by reason of being unusual, extreme, or prominent", name:"Striking", detail: "Synonyms: noticeable, obvious, conspicuous, evident, salient, visible, distinct, prominent, marked, clear-cut, notable, manifest, unmistakable, distinctive, strong"),
                        Word(category:"Meaning: having the power to move heavy weights or perform other physically demanding tasks", name:"Strong", detail: "Synonyms: powerful, muscular, brawny, well built, powerfully built, strapping, sturdy, hefty, burly, meaty, robust, fit, athletic, vigorous, tough, rugged"),
                        Word(category:"Meaning: the arrangement of and relations between the parts or elements of something complex", name:"Structure", detail: "Synonyms: construction, form, formation, shape, composition, fabric, anatomy, make-up, constitution"),
                        Word(category:"Meaning: the devotion of time and attention to gaining knowledge of an academic subject, especially by means of books", name:"Study", detail: "Synonyms: learning, education, schooling, work, academic work, book work, scholarship, tuition, research"),
                        Word(category:"Meaning: extremely impressive or attractive", name:"Stunning", detail: "Synonyms: remarkable, extraordinary, staggering, incredible, impressive, outstanding, amazing, astonishing, marvellous, phenomenal, splendid, imposing, breathtaking, thrilling"),
                        Word(category:"Meaning: a particular procedure by which something is done; a manner or way", name:"Style", detail: "Synonyms: manner, way, technique, method, methodology, approach, system, mode, form, practice"),
                        Word(category:"Meaning: a particular kind of matter with uniform properties", name:"Substance", detail: "Synonyms: material, matter, stuff, medium, fabric"),
                        Word(category:"Meaning: having a firm basis in reality and so important, meaningful, or considerable", name:"Substantive", detail: "Synonyms: noun, common noun, proper noun"),
                        Word(category:"Meaning: (especially of a change or distinction) so delicate or precise as to be difficult to analyse or describe", name:"Subtle", detail: "Synonyms: fine, fine-drawn, ultra-fine, nice, overnice, minute, precise, narrow, tenuous"),
                        Word(category:"Meaning: achieve the desired aim or result", name:"Succeed", detail: "Synonyms: triumph, be victorious, achieve success, be successful, be a success, do well, make good, prosper, flourish, thrive, advance"),
                        Word(category:"Meaning: (especially of something written or spoken) briefly and clearly expressed", name:"Succinct", detail: "Synonyms: concise, short, brief, compact, condensed, crisp, laconic, terse, tight, to the point, economic, pithy, thumbnail, summary, short and sweet"),
                        Word(category:"Meaning: right or appropriate for a particular person, purpose, or situation", name:"Suitable", detail: "Synonyms: acceptable, satisfactory, fit, worthy, fitting"),
                        Word(category:"Meaning: a set of rooms designated for one person's or family's use or for a particular purpose", name:"Suite", detail: "Synonyms: apartment, flat, set of rooms, suite of rooms"),
                        Word(category:"Meaning: of the highest quality or degree", name:"Superlative", detail: "Synonyms: excellent, magnificent, wonderful, glorious, marvellous, brilliant, supreme, consummate, outstanding, prodigious, dazzling, remarkable, formidable, fine"),
                        Word(category:"Meaning: a thing added to something else in order to complete or enhance it", name:"Supplement", detail: "Synonyms: addition, supplementation, additive, extra, companion, add-on, accessory, adjunct, appendage, appurtenance"),
                        Word(category:"Meaning: make (something needed or wanted) available to someone; provide", name:"Supply", detail: "Synonyms: give, contribute, provide, furnish, donate, bestow, grant, endow, afford, impart, lay on, come up with, make available, proffer"),
                        Word(category:"Meaning: bear all or part of the weight of; hold up", name:"Support", detail: "Synonyms: hold up, bear, carry, prop up, keep up, bolster up, brace, shore up, underpin, buttress, reinforce"),
                        Word(category:"Meaning: look closely at or examine (someone or something)", name:"Survey", detail: "Synonyms: look at, look over, take a look at, observe, view, contemplate, regard, see, gaze at, stare at, eye, get a bird's-eye view of"),
                        Word(category:"Meaning: strengthen or support physically or mentally", name:"Sustain", detail: "Synonyms: comfort, help, assist, encourage, succour, support, give strength to, be a source of strength to, be a tower of strength to, buoy up, carry, cheer up"),
                        Word(category:"Meaning: interaction between two different organisms living in close physical association, typically to the advantage of both", name:"Symbiosis", detail: "Synonyms: body, existence, growth, living, man, person, soul, survival, woman"),
                        Word(category:"Meaning: a mark or character used as a conventional representation of an object, function, or process, e.g. the letter or letters standing for a chemical element or a character in musical notation", name:"Symbol", detail: "Synonyms: sign, character, mark, letter, hieroglyph, ideogram"),
                        Word(category:"Meaning: feelings of pity and sorrow for someone else's misfortune", name:"Sympathy", detail: "Synonyms: commiseration, pity, condolence, consolation, comfort, solace, support, encouragement"),
                        Word(category:"Meaning: an elaborate musical composition for full orchestra, typically in four movements, at least one of which is traditionally in sonata form", name:"Symphony", detail: "Synonyms: concert, music, orchestra, harmony"),
                        Word(category:"Meaning: the interaction or cooperation of two or more organizations, substances, or other agents to produce a combined effect greater than the sum of their separate effects", name:"Synergy", detail: "Synonyms: teamwork, alliance, coaction, harmony, symbiosis, synergism, unity"),
                        Word(category:"Meaning: the combination of components or elements to form a connected whole", name:"Synthesis", detail: "Synonyms: combination, union, amalgam, blend, mixture, compound, fusion, coalescence, composite, concoction, conglomerate, alloy"),
                        Word(category:"Meaning: a set of things working together as parts of a mechanism or an interconnecting network; a complex whole", name:"System", detail: "Synonyms: structure, organization, order, arrangement, complex, apparatus, network"),
                        
                        
                        
                        
                        //T
                        
                        Word(category:"Meaning: the equipment required for a task or sport", name:"Tackle", detail: "Synonyms: gear, equipment, apparatus, outfit, kit, rig, hardware"),
                        Word(category:"Meaning: skill and sensitivity in dealing with others or with difficult issues", name:"Tact", detail: "Synonyms: sensitivity, understanding, thoughtfulness, consideration, delicacy, diplomacy, discretion, discernment, judgement, prudence, judiciousness"),
                        Word(category:"Meaning: an action or strategy carefully planned to achieve a specific end", name:"Tactic", detail: "Synonyms: strategy, scheme, stratagem, plan, set of tactics, manoeuvre, course/line of action"),
                        Word(category:"Meaning: a person whose occupation is making fitted clothes such as suits, trousers, and jackets to fit individual customers", name:"Tailor", detail: "Synonyms: outfitter, dressmaker, garment-maker, couturier, fashion designer"),
                        Word(category:"Meaning: natural aptitude or skill", name:"Talent", detail: "Synonyms: flair, aptitude, facility, gift, knack, technique, touch, bent, ability, expertise, capacity, power, faculty"),
                        Word(category:"Meaning: perceptible by touch", name:"Tangible", detail: "Synonyms: touchable, palpable, tactile, material, physical, real, substantial, corporeal, solid, concrete"),
                        Word(category:"Meaning: a person, object, or place selected as the aim of an attack", name:"Target", detail: "Synonyms: prey, quarry, game, kill, bag"),
                        Word(category:"Meaning: a piece of work to be done or undertaken", name:"Task", detail: "Synonyms: job, duty, chore, charge, labour, piece of work, piece of business, assignment, function, commission, mission, engagement, occupation, undertaking, exercise"),
                        Word(category:"Meaning: showing good aesthetic judgement or appropriate behaviour", name:"Tasteful", detail: "Synonyms: in good taste, discriminating, fastidious, refined, cultured, cultivated, sensitive, restrained, harmonious, fitting, fit, becoming, pleasing, elegant, graceful, stylish, smart"),
                        Word(category:"Meaning: a way of carrying out a particular task, especially the execution or performance of an artistic work or a scientific procedure", name:"Technique", detail: "Synonyms: skill, skilfulness, ability, capability, proficiency, expertise, expertness, mastery, talent, genius, artistry, art, craftsmanship, craft"),
                        Word(category:"Meaning: the application of scientific knowledge for practical purposes, especially in industry", name:"Technology", detail: "Synonyms: automation, machinery, computers, mechanics, mechanisation, robotics"),
                        Word(category:"Meaning: the speed at which a passage of music is or should be played", name:"Tempo", detail: "Synonyms: cadence, speed, rhythm, beat, time, pulse"),
                        Word(category:"Meaning: tending to keep a firm hold of something; clinging or adhering closely", name:"Tenacious", detail: "Synonyms: firm, tight, fast, clinging"),
                        Word(category:"Meaning: showing gentleness, kindness, and affection", name:"Tender", detail: "Synonyms: caring, kind, kindly, kind-hearted, soft-hearted, tender-hearted, compassionate, sympathetic, warm, warm-hearted, feeling"),
                        Word(category:"Meaning: not certain or fixed; provisional", name:"Tentative", detail: "Synonyms: provisional, unconfirmed, unsettled, indefinite, pencilled in, preliminary, to be confirmed, TBC, subject to confirmation"),
                        Word(category:"Meaning: a procedure intended to establish the quality, performance, or reliability of something, especially before it is taken into widespread use", name:"Test", detail: "Synonyms: trial, experiment, pilot study, try-out"),
                        Word(category:"Meaning: pleased and relieved", name:"Thankful", detail: "Synonyms: relieved, pleased, glad, grateful"),
                        Word(category:"Meaning: the subject of a talk, piece of writing, exhibition, etc", name:"Theme", detail: "Synonyms: subject, topic, subject matter"),
                        Word(category:"Meaning: concerned with or involving the theory of a subject or area of study rather than its practical application", name:"Theoretical", detail: "Synonyms: not practical, conceptual, abstract, pure"),
                        Word(category:"Meaning: complete with regard to every detail; not superficial or partial", name:"Thorough", detail: "Synonyms: rigorous, in-depth, exhaustive, thoroughgoing, minute, detailed, close, meticulous, scrupulous, assiduous, conscientious, painstaking, methodical"),
                        Word(category:"Meaning: absorbed in or involving thought", name:"Thoughtful", detail: "Synonyms: pensive, thinking, reflective, contemplative, musing, meditative, introspective, prayerful, philosophical, cogitative, ruminative, absorbed, engrossed, rapt"),
                        Word(category:"Meaning: causing excitement and pleasure; exhilarating", name:"Thrilling", detail: "Synonyms: breathtaking, electrifying, enchanting, frantic, gripping, hair-raising, miraculous, riveting"),
                        Word(category:"Meaning: prosper", name:"Thrive", detail: "Synonyms: flourish, prosper, grow vigorously, develop well, burgeon, bloom, blossom, do well, advance, make strides, succeed"),
                        Word(category:"Meaning: arranged neatly and in order", name:"Tidy", detail: "Synonyms: neat, neat and tidy, as neat as a new pin, orderly, well ordered, in (good) order, well kept, shipshape (and Bristol fashion), in apple-pie order"),
                        Word(category:"Meaning: done or occurring at a favourable or useful time", name:"Timely", detail: "Synonyms: opportune, well timed, at the right time, prompt, punctual, convenient, appropriate, suitable, apt, fitting, expedient, felicitous"),
                        Word(category:"Meaning: a musical or vocal sound with reference to its pitch, quality, and strength", name:"Tone", detail: "Synonyms: timbre, sound, sound quality, voice, voice quality, colour, tone colour, tonality, resonance, ring"),
                        Word(category:"Meaning: find or discover by investigation", name:"Trace", detail: "Synonyms: track down, find, discover, detect, unearth, uncover, turn up, hunt down, dig up, ferret out, run to ground"),
                        Word(category:"Meaning: a rough path or road, typically one beaten by use rather than constructed", name:"Track", detail: "Synonyms: path, pathway, footpath, lane, trail, route, way, course"),
                        Word(category:"Meaning: the transmission of customs or beliefs from generation to generation, or the fact of being passed on in this way", name:"Tradition", detail: "Synonyms: historical convention, unwritten law, oral history, heritage"),
                        Word(category:"Meaning: teach (a person or animal) a particular skill or type of behaviour through sustained practice and instruction", name:"Train", detail: "Synonyms: instruct, teach, coach, tutor, give lessons to, school, educate, up-skill, edify, prime, drill, demonstrate something to, make something clear to"),
                        Word(category:"Meaning: free from disturbance; calm", name:"Tranquil", detail: "Synonyms: peaceful, restful, reposeful, calm, quiet, still, serene, placid, relaxing, soothing, undisturbed, idyllic, halcyon, mild, pleasant"),
                        Word(category:"Meaning: (especially of financial assets, liabilities, or legal rights) able to be transferred or made over to the possession of another person", name:"Transferable", detail: "Synonyms: interchangeable, negotiable, assignable, consignable, conveyable"),
                        Word(category:"Meaning: (of a material or article) allowing light to pass through so that objects behind can be distinctly seen", name:"Transparent", detail: "Synonyms: see-through, clear, translucent, pellucid, crystal clear, crystalline, limpid, glassy, glass-like, liquid"),
                        Word(category:"Meaning: a quantity of precious metals, gems, or other valuable objects", name:"Treasure", detail: "Synonyms: riches, valuables, jewels, gems, gold, silver, precious metals, money, cash"),
                        Word(category:"Meaning: behave towards or deal with in a certain way", name:"Treat", detail: "Synonyms: behave towards, act towards, conduct oneself towards, use, serve"),
                        Word(category:"Meaning: very great in amount, scale, or intensity.", name:"Tremendous", detail: "Synonyms: very great, huge, enormous, immense, colossal, massive, prodigious, stupendous, monumental, mammoth, vast, gigantic, giant, mighty, epic"),
                        Word(category:"Meaning: vigorous or incisive in expression or style", name:"Trenchant", detail: "Synonyms: incisive, cutting, pointed, piercing, penetrating, sharp, keen, acute, razor-sharp, razor-edged, rapier-like"),
                        Word(category:"Meaning: a general direction in which something is developing or changing", name:"Trend", detail: "Synonyms: tendency, movement, drift, swing, shift, course, current, run, direction, inclination, leaning"),
                        Word(category:"Meaning: a great victory or achievement", name:"Triumph", detail: "Synonyms: victory, win, conquest, success"),
                        Word(category:"Meaning: believe in the reliability, truth, or ability of", name:"Trusted", detail: "Synonyms: have faith in, put/place one's trust in, have (every) confidence in, believe in, pin one's hopes/faith on"),
                        Word(category:"Meaning: a place where a road branches off from another", name:"Turning", detail: "Synonyms: turn-off, turn, side road, exit; turnout"),
                        Word(category:"Meaning: be characteristic or a representative example of", name:"Typify", detail: "Synonyms: epitomize, exemplify, be representative of, represent, be characteristic of, characterize"),
                        
                        
                        
                        
                        //U
                        
                        Word(category:"Meaning: present, appearing, or found everywhere", name:"Ubiquitous", detail: "Synonyms: omnipresent, ever-present, present everywhere, everywhere, all-over, all over the place, pervasive, all-pervasive, universal, worldwide, global"),
                        Word(category:"Meaning: being or happening at the end of a process; final", name:"Ultimate", detail: "Synonyms: eventual, last, final, concluding, conclusive, terminal, end, endmost, furthest"),
                        Word(category:"Meaning: (of two or more people) fully in agreement", name:"Unanimous", detail: "Synonyms: united, in complete agreement, in complete accord, of one mind, like-minded, of the same mind, in harmony, at one, with one voice, concordant"),
                        Word(category:"Meaning: showing no prejudice for or against something; impartial", name:"Unbiased", detail: "Synonyms: impartial, unprejudiced, non-partisan, neutral, objective, outside, disinterested, without fear or favour, dispassionate, detached, unswayed, even-handed, open-minded"),
                        Word(category:"Meaning: not having or impeded by too many objects, details, or elements", name:"Uncluttered", detail: "Synonyms: accessible, clear, free, susceptible, wide, agape, bare, rent, exposed"),
                        Word(category:"Meaning: not contested", name:"Uncontested", detail: "Synonyms: acknowledged, admitted, arbitrary, assured, certain, final"),
                        Word(category:"Meaning: draw a line under (a word or phrase) to give emphasis or indicate special type", name:"Underline", detail: "Synonyms: underscore, mark, pick out, emphasize, highlight"),
                        Word(category:"Meaning: present participle of underlie", name:"Underlying", detail: "Synonyms: latent, lurking, repressed, suppressed, unrevealed, undisclosed, unexpressed, undivulged, concealed, hidden, veiled, masked, shrouded, under wraps"),
                        Word(category:"Meaning: support (a building or other structure) from below by laying a solid foundation below ground level or by substituting stronger for weaker materials", name:"Underpin", detail: "Synonyms: build, construct, depend, derive, establish, found, hinge"),
                        Word(category:"Meaning: perceive the intended meaning of (words, a language, or a speaker)", name:"Understand", detail: "Synonyms: comprehend, apprehend, grasp, see, take in, perceive, discern, make out, puzzle out, recognize, keep up with, master, get to know, follow, fathom"),
                        Word(category:"Meaning: presented or expressed in a subtle and effective way", name:"Understated", detail: "Synonyms: downplay, lessen, minimise, underrate, undervalue"),
                        Word(category:"Meaning: not disputed or called in question; accepted", name:"Undisputed", detail: "Synonyms: undoubted, uncontested, unchallenged, unquestioned, not in question, unquestionable, indubitable, not in doubt, incontrovertible, incontestable, unequivocal"),
                        Word(category:"Meaning: not questioned or doubted by anyone", name:"Undoubted", detail: "Synonyms: undisputed, uncontested, unchallenged, unquestioned, not in question, unquestionable, indubitable, not in doubt, incontrovertible, irrefutable, incontestable"),
                        Word(category:"Meaning: leaving no doubt; unambiguous", name:"Unequivocal", detail: "Synonyms: unambiguous, unmistakable, indisputable, incontrovertible, indubitable, undeniable"),
                        Word(category:"Meaning: tireless; persistent", name:"Unflagging", detail: "Synonyms: tireless, persistent, dogged, tenacious, determined, resolute, staunch, single-minded, unremitting, unrelenting, unswerving, unfaltering, unfailing, unending"),
                        Word(category:"Meaning: not showing fear or hesitation in the face of danger or difficulty", name:"Unflinching", detail: "Synonyms: resolute, determined, single-minded, dogged, decided, resolved, firm, persistent, persevering, committed, unshrinking, unshakeable, steady"),
                        Word(category:"Meaning: impossible to forget; very memorable", name:"Unforgettable", detail: "Synonyms: memorable, indelible, not/never to be forgotten, fixed in the mind, haunting, catchy, persistent"),
                        Word(category:"Meaning: make or become united, uniform, or whole", name:"Unify", detail: "Synonyms: unite, bring together, join (together), merge, fuse, amalgamate, coalesce, combine, blend, mix, bind, link up, consolidate, integrate, marry"),
                        Word(category:"Meaning: being the only one of its kind; unlike anything else", name:"Unique", detail: "Synonyms: distinctive, individual, special, especial, idiosyncratic, quirky, eccentric, isolated"),
                        Word(category:"Meaning: come or bring together for a common purpose or action", name:"Unite", detail: "Synonyms: unify, join, link, connect, combine, amalgamate, fuse, integrate, weld, bond, stick together, bring together, knit together"),
                        Word(category:"Meaning: the state of being united or joined as a whole", name:"Unity", detail: "Synonyms: union, unification, integration, amalgamation"),
                        Word(category:"Meaning: relating to or done by all people or things in the world or in a particular group; applicable to all cases", name:"Universal", detail: "Synonyms: general, ubiquitous, comprehensive, common, omnipresent, all-embracing, all-inclusive, all-round, across the board"),
                        Word(category:"Meaning: release (a dog) from a leash", name:"Unleash", detail: "Synonyms: let loose, release, free, set free, loose, unloose, unbridle, untie, untether, unchain, unbind, unshackle"),
                        Word(category:"Meaning: having no parallel or equal; exceptional", name:"Unparalleled", detail: "Synonyms: exceptional, unique, singular, rare, unprecedented, without parallel, without equal, unequalled"),
                        Word(category:"Meaning: not able to be done or made again", name:"Unrepeatable", detail: "Synonyms: particular, unique, exclusive, individual, one, single, sole"),
                        Word(category:"Meaning: better than everyone or everything of the same type", name:"Unrivalled", detail: "Synonyms: unequalled, without equal, unparalleled, without parallel, matchless, unmatched, peerless, without peer, unsurpassed, unbeaten, unexcelled"),
                        Word(category:"Meaning: not spoiled, in particular (of a place) not marred by development", name:"Unspoilt", detail: "Synonyms: unimpaired, preserved, intact, as good as new/before, perfect, spotless, pristine, immaculate, virgin, unblemished, unharmed, unbroken, unflawed"),
                        Word(category:"Meaning: not habitually or commonly occurring or done", name:"Unusual", detail: "Synonyms: uncommon, abnormal, atypical, unexpected, surprising, unfamiliar, unwonted, different"),
                        Word(category:"Meaning: make (something) more modern or up to date", name:"Update", detail: "Synonyms: modernize, bring up to date, bring into the twenty-first century, renovate, refurbish, recondition, overhaul, re-equip, improve, better"),
                        Word(category:"Meaning: raise (something) to a higher standard, in particular improve (equipment or machinery) by adding or replacing components", name:"Upgrade", detail: "Synonyms: improve, better, make better, ameliorate, reform, enhance, add to, customize, touch up"),
                        Word(category:"Meaning: lift (something) up; raise", name:"Uplifted", detail: "Synonyms: boost, raise, buoy up, elevate, edify, inspire, lift, give a lift to, cheer up, perk up, enliven, brighten up, lighten, ginger up, gladden"),
                        Word(category:"Meaning: requiring immediate action or attention", name:"Urgent", detail: "Synonyms: acute, grave, pressing, dire, desperate, critical, crucial, sore, serious, intense, crying, burning, compelling, drastic, extreme"),
                        Word(category:"Meaning: modelled on or aiming for a state in which everything is perfect; idealistic", name:"Utopian", detail: "Synonyms: unworldly, non-materialistic, non-material, immaterial"),
                        
                        
                        
                        //V
                        
                        Word(category:"Meaning: (of an argument or point) having a sound basis in logic or fact; reasonable or cogent", name:"Valid", detail: "Synonyms: well founded, sound, well grounded, reasonable, rational, logical, justifiable, defensible, defendable, supportable, sustainable, maintainable, workable"),
                        Word(category:"Meaning: demonstrate or support the truth or value of", name:"Validate", detail: "Synonyms: prove, give proof of, show to be true, give substance to"),
                        Word(category:"Meaning: extremely useful or important", name:"Valuable", detail: "Synonyms: precious, costly, high-priced, high-cost, expensive, dear, worth its weight in gold, worth a king's ransom, priceless, beyond price, without price"),
                        Word(category:"Meaning: the regard that something is held to deserve; the importance, worth, or usefulness of something", name:"Value", detail: "Synonyms: merit, worth, usefulness, use, utility, practicality, advantage, desirability, benefit, gain, profit, good, service, help, helpfulness, assistance, effectiveness"),
                        Word(category:"Meaning: a place or position affording a good view of something", name:"Vantage", detail: "Synonyms: point of view, viewpoint, standpoint, stance, stand, view, opinion, position, way of thinking, frame of mind, outlook, perspective, angle, slant"),
                        Word(category:"Meaning: incorporating a number of different types or elements; showing variation or variety", name:"Varied", detail: "Synonyms: diverse, assorted, diversified, differing, miscellaneous, mixed, motley, sundry, jumbled, haphazard, heterogeneous, manifold, wide-ranging, disparate, variegated"),
                        Word(category:"Meaning: the quality or state of being different or diverse; the absence of uniformity or monotony", name:"Variety", detail: "Synonyms: diversity, variation, diversification, multifariousness, heterogeneity, variegation, many-sidedness, change, difference"),
                        Word(category:"Meaning: showing strong feeling; forceful, passionate, or intense", name:"Vehement", detail: "Synonyms: passionate, forceful, ardent, impassioned, heated, spirited, urgent, fervent, fervid, strong, forcible, powerful, emphatic, vigorous, animated, intense, violent, fierce"),
                        Word(category:"Meaning: a business enterprise, typically one that involves risk", name:"Venture", detail: "Synonyms: enterprise, undertaking, project, scheme, pursuit, operation, endeavour, campaign, activity, act, deed, move, measure, task, exploit, mission, adventure, trial"),
                        Word(category:"Meaning: make sure or demonstrate that (something) is true, accurate, or justified", name:"Verify", detail: "Synonyms: substantiate, confirm, prove, show to be true, corroborate, back up, support, uphold, evidence, establish, demonstrate, demonstrate the truth of, show, show beyond doubt, attest to, testify to, validate, authenticate, endorse, certify, accredit"),
                        Word(category:"Meaning: able to adapt or be adapted to many different functions or activities", name:"Versatile", detail: "Synonyms: adaptable, flexible, all-round, multifaceted, multitalented, multi-skilled, many-sided, resourceful, protean"),
                        Word(category:"Meaning: a person who has had long experience in a particular field", name:"Veteran", detail: "Synonyms: retired soldier"),
                        Word(category:"Meaning: capable of working successfully; feasible", name:"Viable", detail: "Synonyms: workable, feasible, practicable, practical, applicable, usable, manageable, operable, operational, possible, within the bounds/realms of possibility"),
                        Word(category:"Meaning: full of energy and life", name:"Vibrant", detail: "Synonyms: spirited, lively, full of life, full of spirit, high-spirited, energetic, sprightly, vigorous, vital, full of vim and vigour, animated, sparkling, coruscating, effervescent"),
                        Word(category:"Meaning: an act of defeating an enemy or opponent in a battle, game, or other competition", name:"Victory", detail: "Synonyms: success, triumph, conquest, win, successful outcome, positive result, favourable result, landslide, achievement, coup, game, set, and match"),
                        Word(category:"Meaning: keeping careful watch for possible danger or difficulties", name:"Vigilant", detail: "Synonyms: watchful, on the lookout, observant, sharp-eyed, keen-eyed, gimlet-eyed, eagle-eyed, hawk-eyed, with eyes like a hawk, with one's eyes open"),
                        Word(category:"Meaning: strong, healthy, and full of energy", name:"Vigorous", detail: "Synonyms: robust, healthy, in good health, hale and hearty, strong, strong as an ox/horse/lion, sturdy, fine, fit, in good condition, in tip-top condition"),
                        Word(category:"Meaning: the year or place in which wine, especially wine of high quality, was produced", name:"Vintage", detail: "Synonyms: year"),
                        Word(category:"Meaning: able to be perceived or noticed easily", name:"Visible", detail: "Synonyms: perceptible, perceivable, seeable, observable, noticeable, easily seen, detectable, discernible, recognizable, in view, in sight, on view, on display"),
                        Word(category:"Meaning: the faculty or state of being able to see", name:"Vision", detail: "Synonyms: eyesight, sight, power of sight, faculty of sight, ability to see, power of seeing, powers of observation, observation, perception, visual perception"),
                        Word(category:"Meaning: a pleasing view", name:"Vista", detail: "Synonyms: view, prospect, panorama, aspect, perspective, spectacle, sight"),
                        Word(category:"Meaning: relating to seeing or sight", name:"Visual", detail: "Synonyms: optical, seeing, optic, ocular, eye"),
                        Word(category:"Meaning: absolutely necessary; essential", name:"Vital", detail: "Synonyms: essential, indispensable, crucial, key, necessary, needed, required, requisite, important, all-important, of the utmost importance, of great consequence"),
                        Word(category:"Meaning: the state of being strong and active; energy", name:"Vitality", detail: "Synonyms: liveliness, life, energy, animation, spirit, spiritedness, high-spiritedness, vivacity, exuberance, buoyancy, bounce, vibrancy, verve, vim, pep, brio"),
                        Word(category:"Meaning: (especially of a woman) attractively lively and animated", name:"Vivacious", detail: "Synonyms: lively, animated, full of life, spirited, high-spirited, effervescent, bubbling, bubbly, ebullient, buoyant, sparkling, scintillating, light-hearted, carefree"),
                        Word(category:"Meaning: producing powerful feelings or strong, clear images in the mind", name:"Vivid", detail: "Synonyms: graphic, evocative, realistic, true to life, lifelike, faithful, authentic, clear, crystal clear, detailed, lucid, striking, arresting, impressive, colourful, highly coloured"),
                        Word(category:"Meaning: a strong feeling of suitability for a particular career or occupation", name:"Vocation", detail: "Synonyms: calling, life's work, mission, purpose, function, position, niche"),
                        Word(category:"Meaning: the prevailing fashion or style at a particular time", name:"Vogue", detail: "Synonyms: fashion, mode, style, trend, taste, fad, fancy, passing fancy, craze, rage, enthusiasm, passion, infatuation, obsession, mania, fascination"),
                        Word(category:"Meaning: a long journey involving travel by sea or in space", name:"Voyage", detail: "Synonyms: journey, trip, expedition, excursion, tour, hike, trek, tramp, safari, pilgrimage, quest, crusade, odyssey"),
                        
                        
                        
                        
                        //W
                        
                        Word(category:"Meaning: a document issued by a legal or government official authorizing the police or another body to make an arrest, search premises, or carry out some other action relating to the administration of justice", name:"Warrant", detail: "Synonyms: authorization, written order, licence, permit, official document"),
                        Word(category:"Meaning: watching someone or something closely; alert and vigilant", name:"Watchful", detail: "Synonyms: observant, alert, vigilant, attentive, perceptive"),
                        Word(category:"Meaning: an area or ridge of land that separates waters flowing to different rivers, basins, or seas", name:"Watershed", detail: "Synonyms: milestone, watershed, crisis, event, milepost, stage, way-post"),
                        Word(category:"Meaning: an abundance of valuable possessions or money", name:"Wealth", detail: "Synonyms: affluence, prosperity, opulence, riches, means, substance, luxury, well-being, plenty, deep pockets"),
                        Word(category:"Meaning: find out how heavy (someone or something) is, typically using scales", name:"Weigh", detail: "Synonyms: measure the weight of, measure how heavy someone/something is, put someone/something on the scales"),
                        Word(category:"Meaning: a body's relative mass or the quantity of matter contained by it, giving rise to a downward force; the heaviness of a person or thing", name:"Weight", detail: "Synonyms: heaviness, mass, load, burden, pressure, force"),
                        Word(category:"Meaning: greet (someone arriving) in a polite or friendly way", name:"Welcoming", detail: "Synonyms: greet, say hello to, salute, bid someone welcome, play host/hostess to, show hospitality to, receive, meet, embrace, receive with open arms, roll out the red carpet for"),
                        Word(category:"Meaning: showing or characterized by complete sincerity and commitment", name:"Wholehearted", detail: "Synonyms: committed, positive, emphatic, devoted, dedicated, enthusiastic, unshakeable, unflinching, unswerving, constant, staunch, loyal, stalwart"),
                        Word(category:"Meaning: found or distributed over a large area or number of people", name:"Widespread", detail: "Synonyms: general, extensive, universal, common, global, worldwide, international, omnipresent, ubiquitous, wholesale, all-embracing, all-inclusive, all-round"),
                        Word(category:"Meaning: an opening in the wall or roof of a building or vehicle, fitted with glass in a frame to admit light or air and allow people to see out", name:"Window", detail: "Synonyms: casement, opening, aperture"),
                        Word(category:"Meaning: gaining, resulting in, or relating to victory in a contest or competition", name:"Winning", detail: "Synonyms: victorious, successful, triumphant, vanquishing, conquering"),
                        Word(category:"Meaning: attractive or appealing in a fresh, innocent way", name:"Winsome", detail: "Synonyms: appealing, engaging, charming, winning, attractive, pretty, sweet, cute, endearing, darling, dear, lovable, adorable, lovely, delightful, enchanting, captivating, fetching"),
                        Word(category:"Meaning: having or showing experience, knowledge, and good judgement", name:"Wise", detail: "Synonyms: sage, sagacious, intelligent, clever, learned, with/showing great knowledge, knowledgeable, informed, enlightened"),]
    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if splitViewController!.isCollapsed {
      if let selectionIndexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: selectionIndexPath, animated: animated)
      }
    }
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table View
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      searchFooter.setIsFilteringToShow(filteredItemCount: filteredWords.count, of: Words.count)
      return filteredWords.count
    }
    
    searchFooter.setNotFiltering()
    return Words.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let Word: Word
    if isFiltering() {
      Word = filteredWords[indexPath.row]
    } else {
      Word = Words[indexPath.row]
    }
    cell.textLabel!.text = Word.name
    cell.detailTextLabel!.text = Word.category
    return cell
  }
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let Word: Word
        if isFiltering() {
          Word = filteredWords[indexPath.row]
        } else {
          Word = Words[indexPath.row]
        }
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailWord = Word
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
  // MARK: - Private instance methods
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredWords = Words.filter({( Word : Word) -> Bool in
      let doesCategoryMatch = (scope == "All") || (Word.category == scope)
      
      if searchBarIsEmpty() {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && Word.name.lowercased().contains(searchText.lowercased())
      }
    })
    tableView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
  }
}

extension MasterViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
